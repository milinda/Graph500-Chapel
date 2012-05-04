module GRAPH500_Kernel_1 {
	// ijw is an array of 2 dimensions
	// representing the edge list of the graph along with weights
	proc kernel_1(ijw:[]){
		
		// Improve parallelizing here
		var max: int = 0;
		for k in ijw.domain.dim(2) {
			var i = ijw[1,k];
			var j = ijw[2,k];
			if (i != j) then {
				if (i >= max) then max = i;
				if (j >= max) then max = j;
			}
		}
		
		max = max + 1; // going away from zero labels
		var D: domain(2) = [1 .. max, 1..max];
		var G: [D] int = -1;
		
		forall k in ijw.domain.dim(2){
			var i = ijw[1,k] + 1; // going away from zero labels
			var j = ijw[2,k] + 1; // going away from zero labels
			var w = ijw[3,k];
			if (i != j) then {
				G[i,j] = w;
				G[j,i] = w;				
			} 
		}
		
		return G;
	}
	
	
	/* Uncomment for testing kernel_1 alone
	proc main(){
		var arr: [1..3,1..5] int;
		forall (i,j) in arr.domain{
			arr[i,j] = i+j;
		}
		writeln(arr);
		kernel_1(arr);
	}*/
}
