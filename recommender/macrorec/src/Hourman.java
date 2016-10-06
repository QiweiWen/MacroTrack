import java.util.*;
import recommender.Recommender;


public class Hourman {
	public Hourman (){
		TimerTask task = new TimerTask(){
			@Override
			public void run(){
					r.switch_model();
			}
		};
	}
	
	public void set_recommender (Recommender r){
		this.r = r;
	}
	
	public void set_build_new_model (boolean b){
		build_new_model = b;
	}
	
	Timer t = new Timer();
	Recommender r;
}
