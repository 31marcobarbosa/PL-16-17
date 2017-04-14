
GTree* verbos;


void verbos (char* yytext, int indice) {
/* Separar o verbo do resto*/
		int cont = 0;
		char* verb = (char*)malloc(sizeof(char) * 32);
		char* token = strtok(yytext, " ");
		while(token != NULL) {
				token = strtok(NULL, " ");
				if (cont < indice && token != NULL) {
					strdup(verb, token);
				}
				else break;
				cont++;
		}

		int *gp = (int *) g_tree_lookup(verbos,verb);
		if (gp == NULL && strlen(verb) > 1){
			gint* i = g_new(gint,1);
			(*i) = 1;
			g_tree_insert(verbos,verb,i);
		}
		else {
			gint* i = g_new(gint,1);
			gpointer p = g_tree_search(verbos, (GCompareFunc) func ,verb);
			gint cont = *(gint*) gp;
			(*i) = num + 1;
			g_tree_replace(verbos,verb,i);
		}
	}


gboolean func (gpointer k, gpointer v, gpointer cnt){
		return strcmp (k , cnt) == 0;
}

gint comparador(gconstpointer aPtr, gconstpointer bPtr){
	gint i , j;
	i = *(gint *)iPtr;
  	j = *(gint *)jPtr;

	if(i < j) return 1;
	return -1;
}
