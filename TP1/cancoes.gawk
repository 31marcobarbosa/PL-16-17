BEGIN {
	FS= ":"
	i = 0
	PROCINFO["sorted_in"] = "@ind_str_asc";
}


function norm(str) {
  return tolower(str);
}


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
		autores[i] = $2
		gsub(/^ /,"",autores[i])
		gsub(/ $/,"",autores[i])
		i++
		}
}


END {

for ( j = 0 ; j < i ; j++)
	cancoes[autores[j]] = titles[j] "," cancoes[autores[j]]

for (c in cancoes) {
	printf ("%s -> %s\n" , c , cancoes[c])}


}
