package recommender;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.*;

import org.apache.mahout.cf.taste.common.TasteException;
import org.apache.mahout.cf.taste.impl.model.GenericUserPreferenceArray;
import org.apache.mahout.cf.taste.impl.model.PlusAnonymousConcurrentUserDataModel;
import org.apache.mahout.cf.taste.impl.model.file.FileDataModel;
import org.apache.mahout.cf.taste.impl.neighborhood.ThresholdUserNeighborhood;
import org.apache.mahout.cf.taste.impl.recommender.GenericUserBasedRecommender;
import org.apache.mahout.cf.taste.impl.similarity.PearsonCorrelationSimilarity;
import org.apache.mahout.cf.taste.model.DataModel;
import org.apache.mahout.cf.taste.neighborhood.UserNeighborhood;
import org.apache.mahout.cf.taste.recommender.RecommendedItem;
import org.apache.mahout.cf.taste.recommender.UserBasedRecommender;
import org.apache.mahout.cf.taste.similarity.UserSimilarity;

public class Recommender {
	/*
	 * Uses modelfile to build initial model
	 * Save updates to newmodelfile, build new model when asked
	 */
	public Recommender(String modelfile, String newmodelfile) throws IOException, TasteException{
		model = new PlusAnonymousConcurrentUserDataModel(new FileDataModel (new File(modelfile)), 100);
		similarity = new PearsonCorrelationSimilarity(model);
		neighbourhood = new ThresholdUserNeighborhood(0.1, similarity, model);
		recommender = new GenericUserBasedRecommender(model, neighbourhood, similarity);
	}
	
	/*
	 * use new model file to build new model
	 * 
	 */
	public void switch_model(){
		if (dirty){
			dirty = false;
		}
	}
	
	public void new_user (int uid){
		newusers.add(uid);
		dirty = true;
	}
	
	public void update_rating (int uid, int iid, double rating){
		dirty = true;
		numpair <Integer, Integer> p = new numpair <Integer, Integer> (uid, iid);
		List <numpair<Integer,Double>> l = newuserratings.get(uid);
		if (l == null){
			newuserratings.put(uid, new LinkedList <numpair<Integer,Double>> ());
			l = newuserratings.get(uid);
		}
		l.add(new numpair<Integer,Double> (iid, rating));
		newratings.put(p, rating);
	}
	
	public List <RecommendedItem> get_recommendations (int user, int num) throws TasteException{
		 if (newusers.contains(user)){
			 Long tempUserId = model.takeAvailableUser();
			 List <numpair<Integer,Double>> l = newuserratings.get(user);
			 GenericUserPreferenceArray g = 
					 new GenericUserPreferenceArray(l.size());
			 g.setUserID(0, tempUserId);
			 int i = 0;
			 for (numpair<Integer,Double> np: l){
				 g.setItemID(i, np.a);
				 g.setValue(i, np.b.floatValue());
			 }
			 model.setTempPrefs(g, tempUserId);
			 model.releaseUser(tempUserId);
			 List <RecommendedItem> res = recommender.recommend(tempUserId, num);
			 return res;
		 }else{
			 return recommender.recommend(user, num);
		 }
	}
	
	private LinkedList <Integer> newusers = new LinkedList <Integer> ();
	private TreeMap <numpair <Integer, Integer>, Double> newratings =
			new TreeMap <numpair <Integer, Integer>, Double> ();
	
	private TreeMap <Integer, List <numpair <Integer, Double>> > newuserratings = 
			new TreeMap <Integer, List <numpair <Integer, Double>>> ();
	
	PlusAnonymousConcurrentUserDataModel model;
	UserSimilarity similarity;
	UserBasedRecommender recommender;
	UserNeighborhood neighbourhood;
	private boolean dirty = false;
}
