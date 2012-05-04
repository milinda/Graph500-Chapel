module GRAPH500_Kernel_3 {
	proc kernel_3(G:[], root:int){
		var N: int = G.domain.dim(1).last;
		// Adust from zero labels.
		root = root + 1;
		var inf = 9223372036854775807; // represents infinity for weights
		var d: [1 .. N] int = inf;
		var parent: [1 .. N] int = 0;
		d[root] = 0;
		parent[root] = root;
		
		var Q = 1 .. N;
		var len = N;
		while (len > 0){
			var tup = min(d);
			var minimum = tup(1);
			var u = tup(2);
			var du = d[u];
			d[u] = inf; // So this will not be take as a min next time
			len = len - 1;
			for v in Q{
				if (G[u,v] != 0) {
					// Consider only non zero elements
					var dtmp = du + G[u,v];
					if (dtmp < d[v]) then {
						d[v] = dtmp;
						parent[v] = u;
					}
				}
			}
		}
		
		// Adjust back to zero labels
		forall i in parent.domain{
			parent[i] = parent[i] - 1;
		}
		
		return (parent, d);		
	}
	
	// Improve parallelism here
	proc min(arr:[]){
		var min: int = 9223372036854775807;
		var minIdx: int = -1;
		for i in arr.domain.dim(1){
			if (arr[i] < min) then  {
				min = arr[i];
				minIdx = i;
			}
		}
		return (min, minIdx);
	}
	
	proc main()
	{
		var arr: [1 .. 4] int = (1,5,0,3);
		writeln(min(arr));
		var tup = (1,2);
		writeln(tup);
		
		writeln (tup(1));
	}
}
