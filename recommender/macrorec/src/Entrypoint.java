
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

			for (int j = 0; j < 3; ++j){
				r.update_rating(7 - j, 10, 1.0);
				r.update_rating(7 - j, 11, 3.0);
				r.update_rating(7 - j, 15, 4.0);
				r.update_rating(7 - j, 16, 3.0);
				r.update_rating(7 - j, 17, 4.0);
			}
			r.get_recommendations(6, 3);
			r.get_recommendations(7, 3);
			
			List <RecommendedItem> l =  r.get_recommendations(6, 3);
			for (RecommendedItem recom: l){
				System.out.println (recom);
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
