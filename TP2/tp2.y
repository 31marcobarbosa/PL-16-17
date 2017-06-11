%{
	#include <stdio.h>
	#include <string.h>
	#include "abin.c"

	Tree abin

	#define inteiro 1
	#define vetor 2

	FILE *ficheiro;
	char* variavelAtual;
	int cont=0;
	int f;
	int aux;
	int typo;
	int tamanho = 1: 
	int registo;
	int proxRegisto = 0;

%}

%union {
	int valorInt;
	char* valorStr;
}

%token <valorInt> numero
%token <valorStr> var OPA OPR OPM
%token INICIOPROG CORPOPROG	FIMPROG INTEIRO ARRAY SE SENAO FIMCONDICAO ENQUANTO FIMCICLO LER ESCREVER

%%

programa : INICIOPROG iniciavars { fprintf(ficheiro,"START\n"); } CORPOPROG instrucoesprog FIMPROG {fprintf(ficheiro,"STOP\n"); 
																									f = fclose(ficheiro);} 

iniciavars: iniciavar
		  | iniciavar iniciavars
		  ;

iniciavar: tipo {tamanho = 1;} vars ';'
		 | tipo '['numero']' {tamanho = $3;} vars ';'
		 ;


vars: var 				{ variavelAtual = $1; aux = insereAbin(abin, variavelAtual, typo, tamanho, proxRegisto);  
						  if (aux ==-1) { yyerror("A variável já foi declarada!"); exit(0);} 
						  else { fprintf(ficheiro,"PUSHN %d\n",tamanho); proxRegisto = proxRegisto+tamanho;} }
	| var ',' vars 		{ ; }
	;

tipo: INTEIRO {typo = inteiro;}
	| ARRAY	  {typo = vetor;}
	;





instrucoesprog: instrucaoprog ';'					{;}
			  | instrucaoprog instrucoesprog ';'	{;}
			  ;

instrucaoprog: atribuicao							{;}
			 | condicao								{;}
			 | ciclo								{;}
			 | LER '('var')'					{ aux = existeAbin(abin,$3); if(aux == 0) { yyerror("A variável não foi declarada!"); exit(0); } 
			 										  else {  registo = registoVar(abin,$3); fprintf(ficheiro,"READ\nATOI\nSTOREG %d\n",registo);} }
			 | LER '('var 						{ aux = existeAbin(abin,$3); if(aux == 0) { yyerror("A variável não foi declarada!"); exit(0); } 
			 									  else { typo = tipoVar(abin,$3); if(typo != vetor) { yyerror("A variável não é um array!"); exit(0);} 
			 									  else { registo = registoVar(abin,$3); fprintf(ficheiro,"PUSHGP\nPUSHI %d\nPADD\n",registo);} } }

			 		'('expressao')'')'			{ fprintf(ficheiro,"READ\nATOI\nSTOREN\n"); } 
			
			 | ESCREVER '('expressao')'				{ fprintf(ficheiro,"WRITEI\n"); }
			 ;

atribuicao: var '=' expressao					{ aux=existeAbin(abin,$1); if(aux == 0) {yyerror("A variável não foi declarada!"); exit(0); } 
												  else { registo = registoVar(abin,$1); fprintf(ficheiro,"STOREG %d\n",registo); } }
		  | var                                 { aux = existeABin(abin,$1); if(aux == 0) {yyerror("A variável não foi declarada!"); exit(0); } 
		  										  else {  typo = tipoVar(abin,$1); if(typo != vetor) { yyerror("A variável não é um array!"); exit(0);} 
		  										  else { registo = registoVar(abin,$1); fprintf(ficheiro,"PUSHGP\nPUSHI %d\nPADD\n",registo); } } }
			'('expressao')'	'=' expressao 	{ fprintf(ficheiro,"STOREN\n"); }
		  ;

condicao: SE '('cond')' { fprintf(ficheiro,"JZ lab%d\n",cont);} instrucoesprog ou
		;

ou: FIMCONDICAO { fprintf(ficheiro,"lab%d: NOP\n",cont++); }
  | SENAO { fprintf(ficheiro,"JUMP fse%d\nlab%d: NOP\n",cont,cont); } instrucoesprog FIMCONDICAO { fprintf(ficheiro,"fse%d: NOP\n",cont++); }
  ;

ciclo: ENQUANTO { fprintf(ficheiro,"labinicio%d: NOP\n",cont);} '('cond') { fprintf(ficheiro,"JZ fwhile%d\n",cont);} instrucoesprog FIMCICLO { fprintf(ficheiro,"JUMP labinicio%d\nfwhile%d: NOP\n",cont,cont++);}
	 ;


cond: expressao 					 { ; }
	| expressao OPR expressao		 { if( strcmp($2,">") == 0 ) { fprintf(ficheiro,"SUP\n"); }
									   if( strcmp($2,"<") == 0 ) { fprintf(ficheiro,"INF\n"); }
									   if( strcmp($2,"==") == 0 ) { fprintf(ficheiro,"EQUAL\n"); }
								   	   if( strcmp($2,">=") == 0 ) { fprintf(ficheiro,"SUPEQ\n"); }
									   if( strcmp($2,"<=") == 0 ) { fprintf(ficheiro,"INFEQ\n"); }
									   if( strcmp($2,"!=") == 0 ) { fprintf(ficheiro,"EQUAL\nNOT\n"); } }
	;

expressao: parcela					{ ; }	
		 | expressao OPA parcela	{ if( strcmp($2,"+") == 0 ) { fprintf(ficheiro,"ADD\n"); }
									  if( strcmp($2,"-") == 0 ) { fprintf(ficheiro,"SUB\n"); }
									  if( strcmp($2,"||") == 0 ) { fprintf(ficheiro,"ADD\n"); } }		
		 ;



parcela: elemento					{ ; }
	   | parcela 'OPM' elemento	 	{ if( strcmp($2,"*") == 0 ) { fprintf(ficheiro,"MUL\n"); }
									  if( strcmp($2,"/") == 0 ) { fprintf(ficheiro,"DIV\n"); }
								      if( strcmp($2,"&&") == 0 ) { fprintf(ficheiro,"MUL\n"); } }
								      if( strcmp($2,"%") == 0 ) { fprintf(ficheiro,"MOD\n"); } }
	   ;

elemento: var                      { aux = existeAbin(abin,$1); 
									 if(aux == 0) {yyerror("A variável não foi declarada!"); exit(0); } 
									 else { registo = registoVar(abin,$1); fprintf(ficheiro,"LOADG %d\n",registo);} }
		| var 					   { aux = existeABin(abin,$1); if(aux == 0) {yyerror("A variável não foi declarada!"); exit(0); } 
									 else { typo = tipoVar(abin,$1); if(typo != vetor) { yyerror("A variável não é um array!"); exit(0);} 
									 else { registo = registoVar(abin,$1); fprintf(ficheiro,"PUSHGP\nPUSHI %d\nPADD\n",registo);} } }
		  '('expressao')'		   { fprintf(ficheiro,"LOADN\n");}
		| numero				   { fprintf(ficheiro,"PUSHI %d\n",$1); }
		| '('cond')'
		;


%%
#include "lex.yy.c"

int yyerror(char *s) {
	fprintf(stderr, "Erro na linha ( %d! ) %s\n", yylineno, s);
	return 0;
}

int main(int argc, char* argv[]){

	abin = initABin();
	ficheiro = fopen("assembly.txt","w+");

	yyparse();

	return 0;
}