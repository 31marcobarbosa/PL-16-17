V=pl


$V: $V.fl
	flex $V.fl
	gcc -g lex.yy.c `pkg-config --cflags --libs glib-2.0` -o $V

clean:
	rm textoProcessado.txt
	rm $V
	rm lex.yy.c
