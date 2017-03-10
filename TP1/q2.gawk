BEGIN {	PROCINFO["sorted_in"] = "@ind_str_asc"
		fmt = "<li><b>%s:</b> %s</li>\n"
		q2= "Testes/q2.html"
		print "<p><i><a href='indice.html'>Voltar</a></i></p>" > q2

		}

match ($0 , /<SAIDA>(.*)<\/SAIDA>/, locais) {
	local[locais[1]]++
}


END{


		for (l in local)
			printf ("%s : %s<br />", l , local[l]) > q2

}
