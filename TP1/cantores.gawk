BEGIN {
	PROCINFO["sorted_in"] = "@ind_str_asc";
	FS = ":"
}

function norm(str) {
  return tolower(str);
}


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
	for (c in cant)
			print "Cantor -> " c

	y = length(cant)

	printf ("No total são %s cantores.\n" , y )
}
