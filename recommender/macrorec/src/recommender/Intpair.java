package recommender;

 class numpair <T extends Comparable<T>,T2 extends Comparable<T2>> implements Comparable <numpair<T,T2>>{
	public numpair (T a, T2 b){
		this.a = a;
		this.b = b;
	}
	public T a;
	public T2 b;
	
	public int compareTo(numpair <T,T2> other) {
		
		int resa = a.compareTo(other.a);
		if (resa != 0) return resa;
		int resb = b.compareTo(other.b);
		if (resb != 0) return resb;
		return 0;
	}
}
