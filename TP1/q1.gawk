BEGIN {
		PROCINFO["sorted_in"] = "@ind_str_asc"
		fmt = "<li><b>%s:</b> %s</li>\n"
		q1 = "Testes/q1.html"
		print "<p><i><a href='indice.html'>Voltar</a></i></p>" > q1
		}


match($0, /<DATA_ENTRADA>(.*)<\/DATA_ENTRADA>/, entradas) {
	if (entradas[1] != "null")
			dias[entradas[1]]++
	}


END {
	print ("  Data      Nr Entradas<br />") > q1
	for (dia in dias)
		printf ("%s:      %s<br />", dia, dias[dia]) > q1
}
