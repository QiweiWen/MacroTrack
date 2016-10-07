package recommender;
import java.io.*;

import java.util.*;

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
		model = new PlusAnonymousConcurrentUserDataModel(new FileDataModel (new File(modelfile)), 100);
		similarity = new PearsonCorrelationSimilarity(model);
		neighbourhood = new ThresholdUserNeighborhood(0.1, similarity, model);
		recommender = new GenericUserBasedRecommender(model, neighbourhood, similarity);
		//build the list of users in the initial data model
		LongPrimitiveIterator itr = model.getUserIDs();
		oldmodelfile = modelfile;

		while (true){
			try {
				long uid = itr.nextLong();
				knownusers.add(uid);
			}catch (NoSuchElementException e){
				break;
			}
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
				String[] nums = oldline.split(",");
				long uid = Long.parseLong(nums[0]);
				long iid = Long.parseLong(nums[1]);
				//has this rating been updated since?
				numpair <Long, Long> lp = new numpair <Long, Long> (uid, iid);
				if (newratings.containsKey(lp)){
					String newline = String.format("%ld,%ld,%f",uid,iid, newratings.get(lp).floatValue());
					bw.write(newline);
					bw.newLine();
				}else{
					bw.write(oldline);
					bw.newLine();
				}
			}
			br.close();
			/*
			 * add the new users
			 */
			for (Long uid : newusers){
				TreeSet <Long> rated_items = newuserratings.get(uid);
				for (Long rated: rated_items){
					float rating = newratings.get(new numpair <Long,Long> (uid, rated))
							.floatValue();
					String newline = String.format("%ld,%ld,%f", uid, rated, rating);
					bw.write(newline);
					bw.newLine();
				}
				int pos = Collections.binarySearch(knownusers, uid);
			    if (pos < 0) {
			        knownusers.add(-pos-1, uid);
			    }else{
			    	System.err.print("Why is newuser known already?");
			    	System.exit(1);
			    }
			}
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
				model = new PlusAnonymousConcurrentUserDataModel(new FileDataModel(newf),100);
				similarity = new PearsonCorrelationSimilarity(model);
				neighbourhood = new ThresholdUserNeighborhood(0.1, similarity, model);
				recommender = new GenericUserBasedRecommender(model, neighbourhood, similarity);
			}catch (Exception e){
				System.err.println("error moving model files");
				System.exit(1);
			}
			
		}
	}
	
	
	public void update_rating (long uid, long iid, double rating){
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
	
	}
	
	public List <RecommendedItem> get_recommendations (long user, int num) throws TasteException, IOException{
	
	
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
			 System.out.println (g.toString());
			 model.setTempPrefs(g,tempUserId);
			
			 List <RecommendedItem> res;
			 if (tmpmapping.size() == max_newusers){
				 switch_model();
				 res = recommender.recommend(user, num);
			 }else{
				 res = recommender.recommend(tempUserId, num);
				 System.out.println (res.size());
			 }
			 
			// model.releaseUser(tempUserId);
			
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
	
	private String oldmodelfile;
	private final String newmodelfile = "tmpfile";
}
