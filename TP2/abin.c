
#include "abin.h"



typedef struct tree{
    char* nome;
    int tipo;
    int tamanho;
    int registo;
    struct tree esq;
    struct tree dir;
} *Tree;


Tree initABin(){
    Tree t = malloc(sizeof(struct tree));

    t->nome = NULL;
    t->tipo = -1;
    t->tamanho = -1;
    t->registo = -1;
    t->esq = NULL;
    t->dir = NULL;

    return t;
}

int existeAbin(Tree t, char* nome){
    Tree aux;
    if(!t)
        return -1;

    if(t->nome == NULL)
        return -1;

    for(aux = t ; aux && (strcmp(nome,aux->nome)!= 0) ; ){

        if((strcmp(nome,aux->nome)> 0))
            aux = aux->dir;
        else
            aux = aux->esq;
    }

    if(!t)
        return 0;

    return 1;
}


int insertAbin(Tree t, char* nome, int tipo, int tamanho, int registo){
    Tree new;

    if(existeAbin(t,nome) == 1)
        return -1;

    if(!t->nome){
        t->nome = malloc(strlen(nome)+1);
        strcpy(t->nome,nome);
        t->tipo = tipo;
        t->tamanho = tamanho;
        t->registo = registo;
        t->esq = NULL;
        t->dir = NULL;
    }
    else{
        new = malloc(sizeof(struct tree));
        new->nome = malloc(strlen(nome)+1);
        strcpy(new->nome, nome);
        new->tipo =  tipo;
        new->registo = registo;
        new->tamanho = tamanho;
        t->esq = NULL;
        t->dir = NULL;

        Tree aux = t;

        while(aux != NULL){
            if(strcmp(nome,aux->nome) > 0){
                if(aux->dir == NULL){
                    aux->dir = new;
                    return 0;
                }else
                    aux = aux->dir;
            }else{
                if(aux->esq == NULL){
                    aux->esq = new;
                    return 0;
                }else
                    aux = aux->esq;
            }
        }
    }

    return 0;
}

int tipoVar(Tree t, char* nome){
    Tree aux;

    if(t->nome == NULL)
        return -1;

    for(aux = t ; aux && (strcmp(nome,aux->nome) != 0) ;){
        if(strcmp(nome,aux->nome) > 0)
            aux = aux->dir;
        else
            aux = aux->esq;
    }

    if(aux == NULL)
        return -1;

    return aux->tipo;
}
