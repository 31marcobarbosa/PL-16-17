BEGIN {	PROCINFO["sorted_in"] = "@ind_str_asc"
		fmt = "<li><b>%s:</b> %s</li>\n"
		q3 = "Testes/q3.html"
		print "<p><i><a href='indice.html'>Voltar</a></i></p>" > q3

		total = 0
}

match ($0 , /<IMPORTANCIA>(.*)<\/IMPORTANCIA>/, aux) {
		sub(/,/,".", aux[1])
		total += aux[1]
}

END{

	printf ("O total gasto foi %s€<br />", total) > q3

	}
