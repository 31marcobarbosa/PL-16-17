BEGIN {
	PROCINFO["sorted_in"] = "@ind_str_asc";
	enc = "<html> <head> <meta charset='UTF-8'/> <style> body{background-color: moccasin;} h1{text-align: center;}  </style></head> <body>"
	end = "</body> </head>"
	newLine = "<br>"
	div = "<hr></hr>"
	bold = "<b> %s </b>\n"
	path = "Testes/cant.html"
	FS = ":"
}

#function norm(str) {
#  return tolower(str);
#}


{
	if (norm($1) == "singer") {
		if ($2 != " ?"){
			gsub(",",";")
			x = split($2, a, ";")
			for (j in a) {
				gsub("&","e",a[j])
				gsub(/ .$/,"",a[j])
			 	gsub(/^ /,"",a[j])
	 	 		gsub(/ $/,"",a[j])
			 	cant[a[j]]}
		}
	}
}


END {
	print "<p><i><a href='music.html'>Voltar</a></i></p>" > path
	
	print div > path	
	
	print enc > path
	
	print "<h1> Lista de cantores </h1>" > path

	y = length(cant)	

	printf ("<h3>No total temos presentes %s cantores nesta biblioteca. </h3>",y) > path

	print "<ul style=\"list-style-type:disc\">" > path
	for (c in cant)
			printf ("<li> %s </li>", c) > path

	print div > path

	print "</ul>" > path


}
