BEGIN {
	FS= ":"
	i = 0
	enc = "<html> <head> <meta charset='UTF-8'/> <style> body{background-color: moccasin;} h1{text-align: center;}  </style></head> <body>"
	end = "</body> </head>"
	newLine = "<br>"
	div = "<hr></hr>"
	bold = "<b> %s </b>\n"
	canc = "Testes/canc.html"
	PROCINFO["sorted_in"] = "@ind_str_asc";
}


#function norm(str) {
#  return tolower(str);
#}


{
	if (norm($1) == "title") {
			titles[i] = $2
			gsub("*","",titles[i])
			gsub(/^ /,"",titles[i])
			gsub(/ $/,"",titles[i])

		}
}


{
	if (norm($1) == "author") {
		autoress[i] = $2
		gsub(/^ /,"",autoress[i])
		gsub(/ $/,"",autoress[i])
		i++
		}
}


END {
	print "<p><i><a href='music.html'>Voltar</a></i></p>" > canc
	
	print div > canc

for ( j = 0 ; j < i ; j++)
	cancoes[autoress[j]] = titles[j] ", " cancoes[autoress[j]]

	print enc > canc

	print ("<h1> Lista de canções de um dado autor  </h1>") > canc

	print ("<h3> Se um dado autor contiver mais do que uma musica, estas serão apresentadas seperadas por virgulas.  </h3>") > canc
for (c in cancoes) {
	
	printf ("<b> %s </b> <br> <p> %s </p>  ", c , cancoes[c]) > canc
}

	print div > canc

	print end > canc

}
