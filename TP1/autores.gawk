BEGIN {
	PROCINFO["sorted_in"] = "@ind_str_asc";
	FS = ":"
	totalmusicas = 0
}


{
		if ($1 == "author"){
					gsub(/^ /,"",$2)
					gsub(/ $/,"",$2)
					gsub("; ", ";", $2)
					gsub(" ;", ";", $2)
					autores[$2]++
			}
		}


END {


	for (a in autores) {
		totalmusicas += autores[a]
		printf ("%s-> %s \n ", a , autores[a])
	}

	printf ("No total são %s músicas. \n" , totalmusicas)
}
