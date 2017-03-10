BEGIN {	print "\n"
				total = 0
				totalp = 0}

match($0, /<DATA_ENTRADA>(.*)<\/DATA_ENTRADA>/, entradas) {
	dias[entradas[1]]++
}


match ($0 , /<SAIDA>(.*)<\/SAIDA>/, locais) {
	local[locais[1]]++
}

match ($0 , /<IMPORTANCIA>(.*)<\/IMPORTANCIA>/, aux) {
	for (g in aux){
		sub(/,/,".", g);
		total += g;
	}
}


END {
	for (dia in dias)
		printf ("%s : %s\n", dia, dias[dia])

	print "\n"

	for (l in local)
		printf ("%s : %s\n", l , local[l])

	print "\n"

	printf ("O total gasto foi %s€\n", total)

	print "\n"

	printf ("O total gasto em parques foi %s€\n", totalp)
}
