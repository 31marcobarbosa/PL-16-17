
#ifndef __ABIN_H_
#define __ABIN_H_

typedef struct tree{
    char* nome;
    int tipo;
    int tamanho;
    int registo;
    struct tree esq;
    struct tree dir;
} *Tree;


/*
* Inicializar uma arvore binária.
*/
Tree initABin();

/*
* Procura se o elemento com o nome dado existe na árvore
* Retorna 1 se tiver encontrado, 0 caso não exista e - 1 em caso de erro
*/
int existeAbin(Tree t, char* nome);

/*
* Insere o elemento dado na árvore binária. Esta é ordenada pelo nome do elemento.
* Retorna 0 se inserir, -1 se der erro.
*/
int insereAbin(Tree t, char* nome, int tipo, int tamanho, int registo);

/*
* Retorna o tipo da variavel com o nome dado.
*/
int tipoVar(Tree t, char* nome);

/*
* Retorna o registo da variavel com o nome dado.
*/
int registoVar (Tree t, char *nomeVar);

#endif
