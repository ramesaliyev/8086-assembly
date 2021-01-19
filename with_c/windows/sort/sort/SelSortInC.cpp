void SelSortC(int *sdizi, int boyut){
	int i, j, tmp, max;
	for (i = 0; i < boyut - 1; i++){
		max = i;
		for (j = i + 1; j < boyut; j++)
			if (sdizi[j] > sdizi[max])
				max = j;
		tmp = sdizi[max];
		sdizi[max] = sdizi[i];
		sdizi[i] = tmp;
	}
}