BEGIN {
	PROCINFO["sorted_in"] = "@ind_str_asc";
	enc = "<html> <head> <meta charset='UTF-8'/> <style> body{background-color: moccasin;} h1{text-align: center;}  </style></head> <body>"
	end = "</body> </head>"
	newLine = "<br>"
	div = "<hr></hr>"
	bold = "<b> %s </b>\n"
	aut = "Testes/aut.html"
	FS = ":"
}

function norm(str) {
  return tolower(str);
}


{
		if (norm($1) == "author"){
					gsub(/^ /,"",$2)
					gsub(/ *$/,"",$2)
					gsub("; ", ";",$2)
					gsub(" ;", ";",$2)
					autores[$2]++

			}
}


END {
	print "<p><i><a href='music.html'>Voltar</a></i></p>" > aut
	
	print div > aut

	print enc > aut 

	print "<h1> Lista de autores </h1>" > aut
	print "<h3> E o total de canções presentes do dado autor.</h3>" > aut
	
	for (au in autores) {
		printf ("<p><b> %s</b> tem presentes %s musicas </p> \n ", au , autores[au]) > aut
	}
	print div > aut
	print end > aut
}
