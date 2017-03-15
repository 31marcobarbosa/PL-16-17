@include "autores.gawk"
@include "cantores.gawk"
@include "cancoes.gawk"

BEGIN{
	PROCINFO["sorted_in"] = "@ind_str_asc"
	enc = "<html> <head> <meta charset='UTF-8'/> <style> table, th, td { border: 1px solid black;} body{ background-color: moccasin; div { text-align: justify;} div img { display: inline-block; width: 20px; height: 20px;} div:after { content: ''; display: inline-block; width: 100%;}  h1{text-align: center;}</style> </head> <body>"
	music = "Testes/music.html"
	listI = "<li>"
	listE = "</li>\n"
	parI = "<p>"
	parE = "</p>\n"
	bigT = "<h1> %s </h1>\n"
	smallT = "<h3> %s </h3>\n"
	bold = "<b> %s </b>\n"
	newLine = "<br>"
	div = "<hr></hr>"
	ope["cant"] = "Total de cantores e a lista dos seus nomes"
	ope["canc"] = "Total de canções de um dado autor"
	ope["aut"] = "Enunciar todos os autores e as suas musicas correspondentes"
	l = "<li><a href=%s>%s</a></li>"
	end = "</body> </html>"
}

function menu(){
	for (k in ope)
		printf(l , k".html" , ope[k]) > music
}

END{
	
	print enc > music

	print ("<h1> Biblioteca de Letras Musicais </h1>") > music

	print ("<div>\n") > music
	print ("<img src=\"cantor.png\" alt \"Cantor\" />\n") > music
	print ("<img src=\"letras.png\" alt \"Letras\" />\n") > music
	print ("<img src=\"notas.png\" alt \"Notas\" />\n") > music
	print ("<div>\n") > music

	print (parI "A biblioteca aqui presente contêm várias letras de canções famosas, maioritariamente de músicas portuguesas. Para que se possa adicionar um ficheiro a esta biblioteca é necessário que o mesmo tenha uma série de caracteristicas para que se possa fazer a verificação e atualização da biblioteca." parE) > music
	print (parI "Para tal os ficheiros devem obedecer as seguintes regras:" parE) > music

	print ("<ul>") > music
	print (listI "A extensão do ficheiro tem de ser '.lyr'." listE) > music
	print (listI "A letra da musica é precedida de 2 ou mais campos de meta-informação(1 por linha) com o título da canção, o autor da letra(1 ou mais autores), o cantor, etc." listE) > music
	print (listI "A meta-informação é separada da letra por uma linha em branco" listE) > music
	print (listI "Podemos ter ainda um terceiro bloco, também separado por uma linha em branco, que contém a musica escrita na notação midi" listE) > music
	print ("</ul>")	> music

	print div > music

	menu()
	
	print div > music

	print end > music
}
