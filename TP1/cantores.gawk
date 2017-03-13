BEGIN {
	PROCINFO["sorted_in"] = "@ind_str_asc";
	FS = ":"
}

function norm(str) {
  return tolower(str);
}


{
	if (norm($1) == "singer") {
			x = split($2,a,";")
			for (j in a) gsub(/^ /,"",a[j])
			for (j in a) gsub(/ $/,"",a[j])
			for (j in a) cant[a[j]]
		}
}


END {
	for (c in cant)
			print "Cantor -> " c

	y = length(cant)

	printf ("No total são %s cantores.\n" , y )
}
