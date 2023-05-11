%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#if YYBISON
int yylex();
int yyerror();
#endif
char *add(char *coul1, char *coul2);
struct Couleur choix_coul(char *coul);
char *retour_couleur(struct Couleur coul);

struct Couleur{
    int rouge;
    int vert;
    int bleu;
};

%}

%union {
	char *chaine;
	}

%token ROUGE
%token COUL
%token ADD

%type <chaine> instruction
%type <chaine> coul	// Typage de tout les non terminaux
%type <chaine> COUL

%%
instruction:
    coul { printf("Couleur finale: %s\n", $1);free($1);}
    ;

coul:
    coul ADD coul { $$ = add($1, $3);}
    | COUL { $$ = $1; }
    ;
%%



char *add(char *coul1, char *coul2){
    //printf("Début fonction add\n");

    struct Couleur x = choix_coul(coul1);
    printf("couleur numero 1: %d %d %d\n", x.rouge, x.vert, x.bleu);

    struct Couleur y = choix_coul(coul2);
    printf("couleur numero 2: %d %d %d\n", y.rouge, y.vert, y.bleu);

    int new_rouge = x.rouge || y.rouge;
    int new_vert = x.vert || y.vert;
    int new_bleu = x.bleu || y.bleu;



    struct Couleur nouvelle_couleur = {new_rouge, new_vert, new_bleu};

    printf("Couleurs obtenu : %d %d %d\n", new_rouge, new_vert, new_bleu);
    free(coul1);
    free(coul2);

    char *couleur_fin = retour_couleur(nouvelle_couleur);

    return couleur_fin;
};

struct Couleur choix_coul(char *coul){  //Choisit la couleur écrite lors de la compilation
                                        //Renvoit le struct associé à la couleur
   // printf("Dans choix couleur\n");
    if (!strcmp(coul, "noir")){
        struct Couleur noir = {0, 0, 0};
        return noir;
    }
    if (!strcmp(coul, "rouge")){
        struct Couleur rouge = {1, 0, 0};
        return rouge;
    }
    if (!strcmp(coul, "vert")){
        struct Couleur vert = {0, 1, 0};
        return vert;
    }
    if (!strcmp(coul, "bleu")){
        struct Couleur bleu = {0, 0, 1};
        return bleu;
    }
    if (!strcmp(coul, "jaune")){
        struct Couleur jaune = {1, 1, 0};
        return jaune;
    }
    if (!strcmp(coul, "cyan")){
        struct Couleur cyan = {0, 1, 1};
        return cyan;
    }
    if (!strcmp(coul, "magenta")){
        struct Couleur magenta = {1, 0, 1};
        return magenta;
    }
    if (!strcmp(coul, "blanc")){
        struct Couleur blanc = {1, 1, 1};
        return blanc;
    }
};

char *retour_couleur(struct Couleur coul){
    char *couleur = malloc(sizeof(char*) * 10);
    if (coul.rouge == 0 && coul.vert == 0 && coul.bleu == 0){
        sprintf(couleur, "noir");
        return couleur;
    };
    if (coul.rouge == 1 && coul.vert == 0 && coul.bleu == 0){
        sprintf(couleur, "rouge");
        return couleur;
    }
    ;
    if (coul.rouge == 0 && coul.vert == 1 && coul.bleu == 0){
        sprintf(couleur, "vert");
        return couleur;
    }
    ;
    if (coul.rouge == 0 && coul.vert == 0 && coul.bleu == 1){
        sprintf(couleur, "bleu");
        return couleur;
    }
    ;
    if (coul.rouge == 1 && coul.vert == 1 && coul.bleu == 0){
        sprintf(couleur, "jaune");
        return couleur;
    }
    ;
    if (coul.rouge == 0 && coul.vert == 1 && coul.bleu == 1){
        sprintf(couleur, "cyan");
        return couleur;
    }
    ;
    if (coul.rouge == 1 && coul.vert == 0 && coul.bleu == 1){
        sprintf(couleur, "magenta");
        return couleur;
    }
    ;
    if (coul.rouge == 1 && coul.vert == 1 && coul.bleu == 1){
        sprintf(couleur, "blanc");
        return couleur;
    }
    ;
}