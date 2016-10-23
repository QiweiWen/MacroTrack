
import java.io.IOException;
import java.util.List;

import org.apache.mahout.cf.taste.common.TasteException;
import org.apache.mahout.cf.taste.recommender.RecommendedItem;

import MessageThread.MessageHandler;

import recommender.Recommender;


public class Entrypoint {

	/**
	 * @param args
	 */
	public static void main(String[] args)  {
		
		if (args.length != 4){
			System.err.println("Usage: java app control_pipe status_pipe result_pipe initmod");
			System.exit(1);
		}
		
		try {
			Recommender r;
			r = new Recommender (args[3]);
			MessageHandler m = new MessageHandler (args[0], args[1], args[2],r);
			m.start();
			m.join();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (TasteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
