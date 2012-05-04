module GRAPH500_Kernel_3 {
	proc kernel_3(G:[], root:int){
		var N: int = G.domain.dim(1).last;
		// Adust from zero labels.
		root = root + 1;
		var inf = 1000; // represents infinity for weights
		var d: [1 .. N] = inf;
		var parent: [1 .. N] = 0;
		d[root] = 0;
		parent[root] = root;
		
		var Q = 1 .. N;
		
	}
}
