%{

#include "coul.tab.h"

%}

%%

"add"   {return ADD;}
[a-z]* { yylval.chaine = strdup(yytext);
         return COUL;}


[ \t]	{ ; }
\n		{ return 0; }
. 		{ return yytext[0]; }
%%