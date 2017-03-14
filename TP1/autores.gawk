BEGIN {
	PROCINFO["sorted_in"] = "@ind_str_asc";
	FS = ":"
}

function norm(str) {
  return tolower(str);
}


{
		if (norm($1) == "author"){
					gsub(/^ /,"",$2)
					gsub(/ *$/,"",$2)
					gsub("; ", ";", $2)
					gsub(" ;", ";", $2)
					autores[$2]++

			}
}


END {
	for (a in autores) {
		printf ("%s-> %s \n ", a , autores[a])
	}
}
