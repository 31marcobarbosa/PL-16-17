%{
        //#include "y.tab.h"
        //void yyerror(char* );
}

numero      [0-9]+
var         [a-zA-Z]+
espaco      [ \t]+
opA         "+"|"-"|"||"
opM         "&&"|"*"|"/"|"%"
opR         ">"|"<"|">="|"<="|"=="|"!="
inicio      "INICIOPROG"
corpo       "CORPOPROG"
fim         "FIMPROG"
condicao    "SE"
ifelse      "SENAO"
fimCond     "FIMCONDICAO"
ciclo       "ENQUANTO"
fimciclo    "FIMCICLO"
inteiro     "INTEIRO"
vetor       "ARRAY"
read        "LER"
write       "ESCREVER"

%option yylineno

%%

[,;()={}]       {return yytext[0];}
{inicio}        {return INICIOPROG;}
{corpo}         {return CORPOPROG;}
{fim}           {return FIMPROG;}
{condicao}      {return SE;}
{ifelse}        {return SENAO;}
{fimCond}       {return FIMCONDICAO;}
{ciclo}         {return ENQUANTO;}
{fimciclo}      {return FIMCLICLO;}
{opA}           {yylval.vals = strdup(yytext); return (OPA);}
{opR}           {yylval.vals = strdup(yytext); return (OPR);}
{opM}           {yylval.vals = strdup(yytext); return (OPM);}
{vetor}         {yylval.vals = strdup(yytext); return (ARRAY);}
{inteiro}       {yylval.vals = strdup(yytext); return (INTEIRO);}
{read}          {return (READ);}
{write}         {return (WRITE);}
{numero}        {yylval.vali = atoi(yytext); return numero;}
{var}           {yylval.vals = strdup(yytext); return val;}
.|\n            {;}

%%

int yywrap(){
    return(1);
}
