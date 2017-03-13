BEGIN{
	FS= ":"
	i = 0
}

match($0, /title:(.*)/ titlessaux) {
	titles[i] = titlesaux[1]
}

match($0, /author:(.*)/ autoresaux){
	gsub(/^ /,"",autores[i])
	gsub(/ $/,"",autores[i])
	i++
}




END {

for ( j = 0 ; j < i ; j++)
	cancoes[autores[j]] = titles[j]

for (c in cancoes) {
	printf ("%s -> %s\n" , c , cancoes[c])
}


}
