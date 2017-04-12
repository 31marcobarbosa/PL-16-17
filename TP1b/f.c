#include<string.h>

char nomes[1000];
int i=0;


void insere(char *texto) {
nomes = strtok(texto, 'and');
}


void acentos(char *a){
	char aux[1000];
	int j = 0;
	while (a[i] != '\0') {
		if (i >0 && a[i+1]!= '\0' && a[i+1] != '/' && a[i] != '/' && a[i] != '´') {
			if (a[i-1] == '´'){
				switch(a[i]) {
  				case a[i] == 'a': aux[j] = 'á';
      					break;
					case a[i] == 'e': aux[j] = 'é';
								break;
					case a[i] == 'i': aux[j] = 'í';
								break;
					case a[i] == 'o': aux[j] = 'ó';
								break;
      		case a[i] == 'u': aux[j] = 'ú';
                break;
							}
				j++;
			}

			else{
				if (a[i-1] == '~' ){
					switch(a[i]) {
						case a[i] == 'a': aux[j] = 'ã';
      					break;
						case a[i] == 'e': aux[j] = 'õ';
								break;
							}
				}

				else
					aux [j] = a[i];
					j++;
			}

			else {
				if (a[i+1] != '/' && a[i] != '/' && a[i] != '´'){
					aux [j] = a[i];
					j++;
				}
			}

				i++;
			}
		}
		strcpy( a , aux);
		a[j] = '\0';
	}







void print() {

char h[1000]="author = {";

strcat(h,tmp);
int l = strlen(h);
h[l] = '}';
l++;
h[l++]=',';

h[l]='\0';
printf("%s",h);

}
