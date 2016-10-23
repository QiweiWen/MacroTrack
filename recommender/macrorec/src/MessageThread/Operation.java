package MessageThread;


//struct representing a command
public class Operation {
	public Command c;
	public Long[] arg01 = new Long[2];
	public Float arg2;
	public int argnum = 0;
	//parse command from command pipe into an Operation object
	public static Operation parse_operation (String s){
		String [] stuff = s.split(",");
		Operation n = new Operation();
		if (stuff.length < 1 || stuff.length > 4){
			return null;
		}else{
			n.argnum = stuff.length - 1;
			switch (Integer.parseInt(stuff[0])){
				case 0:{
					n.c = Command.get_recs;
					break;
				}
				case 1:{
					n.c = Command.upd_rtng;
					break;
				}
				case 2:{
					n.c = Command.swt_mod;
					break;
				}
				case 3:{
					n.c = Command.exit;
					break;
				}
				default: return null;
			}
			for (int i = 1; i < stuff.length; ++i){
				if (i == 3){
					n.arg2 = Float.parseFloat(stuff[i]);
				}else{
					n.arg01[i - 1] = Long.parseLong(stuff[i]);
				}
			}
			return n;
		}
	}
}
