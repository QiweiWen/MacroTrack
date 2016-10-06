import java.io.File;
import java.io.IOException;

import org.apache.mahout.cf.taste.impl.model.file.FileDataModel;
import org.apache.mahout.cf.taste.model.DataModel;


public class Entrypoint {

	/**
	 * @param args
	 */
	public static void main(String[] args)  {
		if (args.length != 2){
			System.err.print("Usage: infile ofile");
			System.exit(1);
		}
		// TODO Auto-generated method stub
		try {
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
