BEGIN {	print "\n"
				total = 0
				totalp = 0
				i = 0}

match($0, /<DATA_ENTRADA>(.*)<\/DATA_ENTRADA>/, entradas) {
	if (entradas[1] != "null")
		dias[entradas[1]]++
}


match ($0 , /<SAIDA>(.*)<\/SAIDA>/, locais) {
	local[locais[1]]++
}

match ($0 , /<IMPORTANCIA>(.*)<\/IMPORTANCIA>/, aux) {
		sub(/,/,".", aux[1])
		total += aux[1]
}

match ($0 , /<TIPO>(.*)<\/TIPO>/, auxtipo) {
		tipo[i] = auxtipo[1]
		i++
}

match ($0 , /<IMPORTANCIA>(.*)<\/IMPORTANCIA>/, auxcusto) {
		sub(/,/,".", auxcusto[1])
		custo[i] = auxcusto[1]
}

############## -------- ####################

END {
	for (dia in dias)
		printf ("%s : %s\n", dia, dias[dia])

	print "\n"

	for (l in local)
		printf ("%s : %s\n", l , local[l])

	print "\n"


	printf ("O total gasto foi %s€\n", total)

	print "\n"

	for (j = 0 ; j <= i ; j ++ ){
		if (tipo[j] == "Parques de estacionamento")
			totalp += custo[j]
	}


	printf ("O total gasto em parques foi %s€\n", totalp)
}
