

%{
/*                                                                              
 *Filename        lex.l                                                       
 *Date            3/27/19                                                       
 *Author          Gabriel Goldstein                                             
 *Email           gjg180000@utdallas.edu                                        
 *Course          CS 3377.502 Spring 2019                                       
 *Version         1.0                                                           
 *Copyright 2019, All Rights Reserved                                           
 *                                                                              
 *Description                                                                   
 *      Lexical analyzer, whcih matches expressions and returns tokens.                                                                         
 *      
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "yacc.tab.h"
#include "program4.h"
%}

%option noyywrap

%option nounput

%option noinput

%%
[\t ] { /* remove whitespaces*/  
}

([IVXLCDM]+) { /* Find roman numerals*/
strcpy(s.tokenType, "ROMANTOKEN");
yylval.str = strdup(yytext);  
return ROMANTOKEN;                                                             
}

[A-Za-z]{2,1000} { /* Find Names*/
strcpy(s.tokenType, "NAMETOKEN");
yylval.str = strdup(yytext);
return NAMETOKEN;
}
[0-9]+ { /*Find numbers*/
strcpy(s.tokenType, "INTTOKEN");  
yylval.str = strdup(yytext);
return INTTOKEN;                                                        
}
[A-Za-z]{1}[.]* { /*Find intials potentially follwed by a period*/
strcpy(s.tokenType, "NAME_INITIAL_TOKEN");                                    
yylval.str = strdup(yytext);                                                  
return NAME_INITIAL_TOKEN;                                                                                        
}

[A-Za-z0-9]+ {  /*Find something with letters and/or number*/ 
strcpy(s.tokenType, "IDENTIFIERTOKEN");  
yylval.str = strdup(yytext);                                                   
return IDENTIFIERTOKEN;
}

Sr. { /*Find senior token*/
strcpy(s.tokenType, "SRTOKEN");  
yylval.str = strdup(yytext);  
return SRTOKEN; 
}
Jr. {/*Find junior token*/
strcpy(s.tokenType, "JRTOKEN");  
yylval.str = strdup(yytext);  
return JRTOKEN;
}
\n {	/*Find new line*/
strcpy(s.tokenType, "EOLTOKEN");  
return EOLTOKEN;
}
, { /*Find comma*/
strcpy(s.tokenType, "COMMATOKEN");  
return COMMATOKEN;
}
‐ { /*Find dash*/
strcpy(s.tokenType, "DASHTOKEN");  
return DASHTOKEN;
}
# { /*Find hashtag*/
strcpy(s.tokenType, "HASHTOKEN");
return HASHTOKEN;
}
%%

