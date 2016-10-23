package recommender;
import java.io.*;

import java.util.*;
import java.util.Map.Entry;

import org.apache.mahout.cf.taste.common.TasteException;
import org.apache.mahout.cf.taste.impl.common.LongPrimitiveIterator;
import org.apache.mahout.cf.taste.impl.model.GenericUserPreferenceArray;
import org.apache.mahout.cf.taste.impl.model.PlusAnonymousConcurrentUserDataModel;
import org.apache.mahout.cf.taste.impl.model.file.FileDataModel;
import org.apache.mahout.cf.taste.impl.neighborhood.ThresholdUserNeighborhood;
import org.apache.mahout.cf.taste.impl.recommender.GenericUserBasedRecommender;
import org.apache.mahout.cf.taste.impl.similarity.PearsonCorrelationSimilarity;
import org.apache.mahout.cf.taste.neighborhood.UserNeighborhood;
import org.apache.mahout.cf.taste.recommender.RecommendedItem;
import org.apache.mahout.cf.taste.recommender.UserBasedRecommender;
import org.apache.mahout.cf.taste.similarity.UserSimilarity;


public class Recommender {
	/*
	 * Uses modelfile to build initial model
	 * Save updates to newmodelfile, build new model when asked
	 */
	public Recommender(String modelfile) throws IOException, TasteException{
		try{
			oldmodelfile = modelfile;
			
			model = new PlusAnonymousConcurrentUserDataModel(new FileDataModel (new File(modelfile)), max_newusers);
			similarity = new PearsonCorrelationSimilarity(model);
			neighbourhood = new ThresholdUserNeighborhood(0.1, similarity, model);
			recommender = new GenericUserBasedRecommender(model, neighbourhood, similarity);
			//build the list of users in the initial data model
			LongPrimitiveIterator itr = model.getUserIDs();
			

			while (true){
				try {
					long uid = itr.nextLong();
					knownusers.add(uid);
				}catch (NoSuchElementException e){
					break;
				}
			}
		}catch (Exception te){
			model_is_empty = true;
		}
		
	}
	
	/*
	 * use new model file to build new model
	 * 
	 */
	public void switch_model() throws IOException{
		if (dirty){
			dirty = false;
			BufferedReader br = new BufferedReader (new FileReader (oldmodelfile));
			BufferedWriter bw = new BufferedWriter (new FileWriter (newmodelfile));
			String oldline;
			/*
			 *  insert the modified entries
			 */
			while ((oldline = br.readLine()) != null){
				if (oldline.length() == 0) continue;
				String[] nums = oldline.split(",");
				long uid = Long.parseLong(nums[0]);
				long iid = Long.parseLong(nums[1]);
				//has this rating been updated since?
				numpair <Long, Long> lp = new numpair <Long, Long> (uid, iid);
				if (newratings.containsKey(lp)){
					
					String newline = String.format("%d,%d,%f",uid,iid, newratings.get(lp).floatValue());
					newratings.remove(lp);
					bw.write(newline);
					bw.newLine();
				}else{
					bw.write(oldline);
					bw.newLine();
				}
			}
			br.close();
			//write remaining entries into newmodelfile
			Set<Entry<numpair<Long, Long>, Double>> remaining = newratings.entrySet();
			for (Entry <numpair<Long,Long>, Double> e: remaining){
				 long uid = e.getKey().a.longValue();
				 long iid = e.getKey().b.longValue();
				 Double rating = e.getValue();
				 String newline = String.format("%d,%d,%f",uid,iid, rating.floatValue());
				 bw.write(newline);
				 bw.newLine();
			}
			/*
			 * add the new users
			 */
			
			for (Long uid : newusers){

				int pos = Collections.binarySearch(knownusers, uid);
			    if (pos < 0) {
			        knownusers.add(-pos-1, uid);
			    }else{
			    	System.err.print("Why is newuser known already?");
			    	System.exit(1);
			    }
			}
			
			System.out.println (knownusers);
			bw.close();
			/*
			 * clear the data structures
			 * might be faster just to make new ones
			 * yay garbage collector
			 */
		
			newusers.clear();
			newuserratings = new TreeMap <Long, TreeSet <Long>> ();
			newratings = new TreeMap <numpair <Long, Long>, Double> ();
			tmpmapping.clear();
			/*
			 * rename the files
			 * make the new model
			 */
			try{
				File oldf = new File (oldmodelfile);
				oldf.delete();
				File newf = new File (newmodelfile);
				newf.renameTo(oldf);
				model = new PlusAnonymousConcurrentUserDataModel(new FileDataModel(oldf),max_newusers);
				similarity = new PearsonCorrelationSimilarity(model);
				neighbourhood = new ThresholdUserNeighborhood(0.1, similarity, model);
				recommender = new GenericUserBasedRecommender(model, neighbourhood, similarity);
			}catch (IOException e){
				System.err.println("error moving model files");
				System.err.println(e.getMessage());
				System.exit(1);
			} catch (TasteException e) {
				e.printStackTrace();
				System.exit(1);
			}
			
		}
	}
	
	
	public void update_rating (long uid, long iid, double rating) throws IOException{
		dirty = true;
	
		numpair <Long, Long> p = new numpair <Long, Long> (uid, iid);
		newratings.put(p, rating);
	
		//can use binary search because knownusers was populated in order
		if (java.util.Collections.binarySearch(knownusers,uid) < 0){
			if (!newusers.contains(uid)){
				newusers.add(uid);
			}
			
			TreeSet <Long> l = newuserratings.get(uid);
			if (l == null){
				newuserratings.put(uid, new TreeSet <Long> ());
				l = newuserratings.get(uid);
			}
			if (! l.contains(iid)){
				l.add(iid);
			}
		}
		if (model_is_empty){
			model_is_empty = false;
			switch_model();
		}
	
	}
	
	public List <RecommendedItem> get_recommendations (long user, int num) throws TasteException, IOException{
	
		 if (model_is_empty) {
			 return new LinkedList <RecommendedItem> ();
		 }
		 if (newusers.contains(user) && !tmpmapping.containsKey(user)){
			 Long tempUserId = model.takeAvailableUser();
			
			 tmpmapping.put(user, tempUserId);
			 TreeSet <Long> l = newuserratings.get(user);
			 GenericUserPreferenceArray g = 
					 new GenericUserPreferenceArray(l.size());
			 g.setUserID(0, tempUserId);
			 int i = 0;
			 for (Long rated: l){
				 float rating = newratings.get(new numpair<Long,Long> (new Long (user),rated)).floatValue();
				
				 g.setItemID(i, rated);
				 g.setValue(i, rating);
				 i++;
			 }
			// System.out.println (g.toString());
			 model.setTempPrefs(g,tempUserId);
			
			 List <RecommendedItem> res;
			// System.out.println (tmpmapping.size() + "," + max_newusers);
			 if (tmpmapping.size() == max_newusers){
				 
				 switch_model();
				 res = recommender.recommend(user, num);
			 }else{
				 res = recommender.recommend(tempUserId, num);
				// System.out.println (res.size());
			 }
			
			 return res;
		 }else{
			 if (tmpmapping.containsKey(user)){
				 return recommender.recommend(tmpmapping.get(user), num);
			 }else
				 return recommender.recommend(user, num);
		 }
	}
	
	//maximum number of new users until the model is rebuilt
	private final int  max_newusers = 100;
	//users included in this data model
	private ArrayList <Long> knownusers = new ArrayList<Long> ();
	//users to be added to the next data model
	private LinkedList <Long> newusers = new LinkedList <Long> ();

	//(user,item) -> rating
	private TreeMap <numpair <Long, Long>, Double> newratings =
			new TreeMap <numpair <Long, Long>, Double> ();
	//user -> [(item, rating)]
	private TreeMap <Long, TreeSet <Long> >  newuserratings = 
			new TreeMap <Long, TreeSet <Long> > ();
	//user->tmpuser
    private TreeMap <Long,Long> tmpmapping =
    		new TreeMap <Long,Long> ();
	
	private PlusAnonymousConcurrentUserDataModel model;
	private UserSimilarity similarity;
	private UserBasedRecommender recommender;
	private UserNeighborhood neighbourhood;
	private boolean dirty = false;
	private boolean model_is_empty = false;
	private String oldmodelfile;
	private final String newmodelfile = "tmpfile";
}
