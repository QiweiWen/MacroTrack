package MessageThread;

import java.io.*;

import org.apache.mahout.cf.taste.common.TasteException;
import org.apache.mahout.cf.taste.recommender.RecommendedItem;
import recommender.*;
import java.util.*;

public class MessageHandler implements Runnable {

	public MessageHandler (String cmdpipe, String stpipe, 
						String resultpipe, Recommender r) throws FileNotFoundException{
		this.stpipe = new RandomAccessFile (stpipe,"rw");
		this.cmdpipe = new RandomAccessFile (cmdpipe, "rw");
		System.out.println (cmdpipe);
		this.resultpipe = new RandomAccessFile (resultpipe, "rw");
		this.t = new Thread(this);
		this.r = r;
	}
	
	private void report_success() throws IOException{
		String s = "0";
		stpipe.write(s.getBytes());
		stpipe.writeBytes(System.getProperty("line.separator"));
	}
	
	private void report_failure () throws IOException{
		String s = "1";
		stpipe.write(s.getBytes());
		stpipe.writeBytes(System.getProperty("line.separator"));
	}
	
	private void give_recommendations (long user, int num) throws TasteException, IOException{
		List <RecommendedItem> l = r.get_recommendations(user, num);
		
		if (l.size() == 0){
			report_failure();
		}
		
		for (RecommendedItem i: l){
			Long itemid = i.getItemID();
			Float val = i.getValue();
			System.out.println (i);
			resultpipe.write((Long.toString(itemid)).getBytes());
			resultpipe.write(",".getBytes());
			resultpipe.write((Float.toString(val)).getBytes());
			resultpipe.writeBytes(System.getProperty("line.separator"));
		}
		report_success();
	}
	
	public void run() {
		// TODO Auto-generated method stub
		try {
			String command;
			System.out.println ("WAITING");
		
			while ((command = cmdpipe.readLine()) != null){
				Operation o = Operation.parse_operation(command);
				
				boolean threadend = false;
				switch (o.c){
					
					case  get_recs:{
						if (o.argnum != 2){
							report_failure();
						}else{
							give_recommendations(o.arg01[0],o.arg01[1].intValue());
						}
						break;
					}
					case  upd_rtng:{
						if (o.argnum != 3){
							report_failure();
						}else{
							r.update_rating(o.arg01[0].longValue(), 
											o.arg01[1].longValue(), 
											o.arg2.floatValue());
							report_success();
						}
						break;
					}
					case  swt_mod:{
						r.switch_model();
						report_success();
						break;
					}
					case  exit:{
						r.switch_model();
						report_success();
						threadend = true;
						break;
					}
					default: {threadend = true; break;}
				}
				if (threadend){
					System.out.println("Message Thread Terminating");
					break;
				}
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.err.println("error reading from/writing to named pipe");
			e.printStackTrace();
		} catch (TasteException e) {
			System.err.println("error while recommending item");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void join() throws InterruptedException{
		if (t != null){
			t.join();
		}
	}
	public void start(){
		t.start();
	}
	private Thread t;
	private RandomAccessFile stpipe;
	private RandomAccessFile cmdpipe;
	private RandomAccessFile resultpipe;
	private Recommender r;
}
