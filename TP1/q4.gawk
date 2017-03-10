BEGIN {	PROCINFO["sorted_in"] = "@ind_str_asc"
		fmt = "<li><b>%s:</b> %s</li>\n"
		q4 = "Testes/q4.html"
		print "<p><i><a href='indice.html'>Voltar</a></i></p>" > q4

		totalp = 0
		}

		match ($0 , /<TIPO>(.*)<\/TIPO>/, auxtipo) {
				tipo[i] = auxtipo[1]
				i++
		}

		match ($0 , /<IMPORTANCIA>(.*)<\/IMPORTANCIA>/, auxcusto) {
				sub(/,/,".", auxcusto[1])
				custo[i] = auxcusto[1]
		}

END{

			for (j = 0 ; j <= i ; j ++ ){
				if (tipo[j] == "Parques de estacionamento")
					totalp += custo[j]
			}

			printf ("O total gasto em parques foi %s€<br />", totalp) > q4
		}
