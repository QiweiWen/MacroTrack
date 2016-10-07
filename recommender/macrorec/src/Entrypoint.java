
import java.io.IOException;
import java.util.List;

import org.apache.mahout.cf.taste.common.TasteException;
import org.apache.mahout.cf.taste.recommender.RecommendedItem;

import recommender.Recommender;


public class Entrypoint {

	/**
	 * @param args
	 */
	public static void main(String[] args)  {
		/*
		if (args.length != 2){
			System.err.print("Usage: infile ofile");
			System.exit(1);
		}
		*/
		// TODO Auto-generated method stub
		try {
			Recommender r = new Recommender ("test");
			r.update_rating(5, 10, 1.0);
			r.update_rating(5, 11, 3.0);
			r.update_rating(5, 15, 4.0);
			r.update_rating(5, 16, 3.0);
			r.update_rating(5, 17, 4.0);
			List <RecommendedItem> l = r.get_recommendations(5, 3);
			for (RecommendedItem item : l){
				System.out.println(item);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (TasteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
