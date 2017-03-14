
BEGIN {
		PROCINFO["sorted_in"] = "@ind_str_asc"
		enc = "<html> <head> <meta charset='UTF-8'/> <style> table, th, td { border: 1px solid black;} body{ background-image url: ;} h1{text-align: center;}</style> </head> <body>"
		fmt = "<li><b>%s:</b> %s</li>\n"
		header  = "Testes/indice.html"
		q1 = "Testes/q1.html"
		q2 = "Testes/q2.html"
		q3 = "Testes/q3.html"
		q4 = "Testes/q4.html"
		listI = "<li>"
		listE = "</li>\n"
		parI = "<p>"
		parE = "</p>\n"
		bigT = "<h1> %s </h1>\n"
		smallT = "<h3> %s </h3>\n"
		bold = "<b> %s </b>\n"
		newLine= "<br>"
		div = "<hr></hr>"
		op["q1"] = "Número de entradas em cada dia do mês"
		op["q2"] = "Lista de locais de saída"
		op["q3"] = "Total gasto no mês"
		op["q4"] = "Total gasto no mês apenas em parques de estacionamento"
		l = "<li><a href=%s>%s</a></li>"
		total = 0
		totalp = 0
		pth="Testes/"
		end  = "</body> </html>"		
}
l
#questao1
match ($0 , "<DATA_ENTRADA>(.*)</DATA_ENTRADA>", entradas) {
	if (entradas[1] != "null")
			dias[entradas[1]]++
}

#questao2
match ($0 , "<SAIDA>(.*)</SAIDA>", locais) {
	local[locais[1]]++
}

#questao3
match ($0 , "<IMPORTANCIA>(.*)</IMPORTANCIA>", aux) {
		sub(/,/,".", aux[1])
		total += aux[1]
}

#questao4
match ($0 , "<TIPO>(.*)</TIPO>", auxtipo) {
				tipo[i] = auxtipo[1]
				i++
}

match ($0 , "<IMPORTANCIA>(.*)</IMPORTANCIA>", auxcusto) {
				sub(/,/,".", auxcusto[1])
				custo[i] = auxcusto[1]
}


#----- CABEÇALHO ----------


match ($0 , "<NIF>(.*)</NIF>", nifs){
	nif = nifs[1];
}

match( $0 , "<MES_EMISSAO>(.*)</MES_EMISSAO>",meses){
	mes = meses[1];
}

match($0 , "<NOME>(.*)</NOME>",nomes){
	nome = nomes[1];
}

match($0 , "<MORADA>(.*)</MORADA>", moradas){
	morada = moradas[1];
}

match ($0 , "<LOCALIDADE>(.*)</LOCALIDADE>", locaise) {
	locale = locaise[1];
}

match ($0 , "<CODIGO_POSTAL>(.*)</CODIGO_POSTAL>", postais) {
	codigo = postais[1];
}

match ($0 , "<MATRICULA>(.*)</MATRICULA>",matriculas){
	matricula = matriculas[1];
}

match ($0 , "<REF_PAGAMENTO>(.*)</REF_PAGAMENTO>",refs){
	ref = refs[1];
}

function questao1(){
	print "<p><i><a href='indice.html'>Voltar</a></i></p>" > q1

	print enc > q1

	printf(smallT, "Numero de entradas referentes a cada dia do mês") > q1

	print "<table style=\"width:100%\">" > q1
	print "<tr> <th> Data </th> <th> Numero de Entradas </th> </tr>" >q1
	for (dia in dias){
		printf("<tr> <th> %s </th> <th> %s </th> </tr>",dia,dias[dia]) > q1
	}
	print "</table>" > q1	

	print end > q1
}

function questao2(){
	print "<p><i><a href='indice.html'>Voltar</a></i></p>" > q2

	print enc > q2

	printf(smallT, "Locais de saída") > q2

	print "<table style=\"width:100%\">" > q2
	print "<tr> <th> Local </th> <th> Numero de Saídas </th> </tr>" >q2
	for (l in local){
		printf("<tr> <th> %s </th> <th> %s </th> </tr>",l,local[l]) > q2
	}
	
	print "</table>" > q2

	print end > q2
}

function questao3(){
	print "<p><i><a href='indice.html'>Voltar</a></i></p>" > q3

	print enc > q3
	
	printf("<h3>Total gasto referente ao mês %s</h3>",mes) > q3
	
	printf("O total gasto no mês apresentado foi de %s€",total) > q3

	print end > q3
}

function questao4(){
	print "<p><i><a href='indice.html'>Voltar</a></i></p>" > q4

	print enc > q4

	printf("<h3>Total gasto em parques referente ao mês %s</h3>",mes) > q4

	for( j = 0 ; j <= i ; j++){
		if (tipo[j] == "Parques de estacionamento")
			totalp += custo[j]
	}
	
	printf("O total gasto no mês apresentado em parques foi de %s€",totalp) > q4
	
	print end > q4
}
function indice() {
    for (k in op)
        printf (l, k ".html" , op[k]) > "Testes/indice.html"
}

END{
	print enc > header
	
	printf(bigT bigT "Referente à matricula %s.","Extracto Mensal ViaVerde", mes, matricula) > header

	printf(newLine bold,"Referencia pagamento:") > header
	
	printf("%s", ref) > header
	
	print div > header

	printf(bold "%s" newLine newLine ,"Nome: ", nome) > header
	
	printf(bold "%s" newLine newLine,"NIF: ",nif) > header

	printf(bold "%s, " "%s, " "%s" newLine newLine,"Morada: ",morada,locale,codigo) > header

	print div > header
	
	printf(newLine bold, "Consulte:") > header

	indice()

	print div > header

	questao1()

	questao2()

	questao3()

	questao4()

	
	print end > header
}
