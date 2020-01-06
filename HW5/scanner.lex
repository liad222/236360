%{

/* Declarations section */
#include <stdio.h>
#include "classes.hpp"
#include "parser.tab.hpp"
%}

%option yylineno
%option noyywrap
digit   		  ([1-9])
letter  		  ([a-zA-Z])
whitespace	  ([\t\n\r ])
%x STRINGS
%%

void                               yylval=new Node(yytext);   return VOID;
int                                yylval=new Node(yytext);   return INT;
byte                               yylval=new Node(yytext);   return BYTE;
b                                  yylval=new Node(yytext);   return B;
bool                               yylval=new Node(yytext);   return BOOL;
enum                               yylval=new Node(yytext);   return ENUM;
and                                yylval=new Node(yytext);   return AND;
or                                 yylval=new Node(yytext);   return OR;
not                                yylval=new Node(yytext);   return NOT;
true                               yylval=new Node(yytext);   return TRUE;
false                              yylval=new Node(yytext);   return FALSE;
return                             yylval=new Node(yytext);   return RETURN;
if                                 yylval=new Node(yytext);   return IF;
else                               yylval=new Node(yytext);   return ELSE;
while                              yylval=new Node(yytext);   return WHILE;
break                              yylval=new Node(yytext);   return BREAK;
continue                           yylval=new Node(yytext);   return CONTINUE;
(\;)                               yylval=new Node(yytext);   return SC;
(\,)                               yylval=new Node(yytext);   return COMMA;
(\()                               yylval=new Node(yytext);   return LPAREN;
(\))                               yylval=new Node(yytext);   return RPAREN;
(\{)                               yylval=new Node(yytext);   return LBRACE;
(\})                               yylval=new Node(yytext);   return RBRACE;
(=)                                yylval=new Node(yytext);   return ASSIGN;
(==)|(!=)                      		 yylval=new Node(yytext);	  return RELOPL;
(<)|(>)|(<=)|(>=)                  yylval=new Node(yytext);   return RELOPN;
\+|\-                              yylval=new Node(yytext);   return ADD;
\*|\/							                 yylval=new Node(yytext);   return MUL;
[a-zA-Z][a-zA-Z0-9]*               yylval=new Node(yytext);   return ID;
({digit}({digit}|0)*)|0            yylval=new Node(yytext);   return NUM;
(\")                                  BEGIN(STRINGS);
<STRINGS><<EOF>>                      {output::errorLex(yylineno); exit(0);};
<STRINGS>([\x00-\x09\x0b-\x0c\x0e-\x21\x23-\x5b\x5d-\x7f]|((\\)(\\))|((\\)(\"))|((\\)(n))|((\\)(r)))*(\") {BEGIN(INITIAL);  yylval=new Node(yytext);  return STRING;}
<STRINGS>([^(\")])*((\")?)            {output::errorLex(yylineno); exit(0);};
{whitespace}				                  ;
\/\/[^\r\n]*[\r|\n|\r\n|\n\r]?        ;
.                                     {output::errorLex(yylineno); exit(0);};



%%
