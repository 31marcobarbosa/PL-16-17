BEGIN { PROCINFO["sorted_in"] = "@ind_str_asc"
		fmt = "<li><b>%s:</b> %s</li>\n"
		header = "Testes/header.html"
		print "<p><i><a href='indice.htlm'>Voltar</a></i></p>" > header
	}

match ($0, /<NIF>(.*)<\/NIF>/, nif){
	nifs[nif[1]]++
}


END{
		
	printf ("NIF: %s <br />",nifs[1]) > header
}
