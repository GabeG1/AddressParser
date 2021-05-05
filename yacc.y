/*                                                                              
 *Filename        yacc.y                                                       
 *Date            3/27/19                                                      
 *Author          Gabriel Goldstein                                             
 *Email           gjg180000@utdallas.edu                                        
 *Course          CS 3377.502 Spring 2019                                       
 *Version         1.0                                                           
 *Copyright 2019, All Rights Reserved                                           
 *                                                                              
 *Description                                                                   
 *         Grammer Rules for postal addresses                                                                     
 *      
 */

%{
#include <stdio.h>
#include <string.h>
#include "program4.h"
  int yylex();
%}


%union
 {
   char* str;
   int i;
}

//Declare the tokens
%token  NAMETOKEN
%token  IDENTIFIERTOKEN
%token  NAME_INITIAL_TOKEN
%token  ROMANTOKEN
%token  SRTOKEN
%token  JRTOKEN
%token  EOLTOKEN
%token  INTTOKEN
%token  COMMATOKEN
%token  DASHTOKEN
%token  HASHTOKEN

 //Declare type string for terminals and nonterminals
%type<str> postaladdresses namepart personalpart addressblock lastname
%type<str> suffixpart streetaddress streetnumber streetname locationpart
%type<str> townname statecode zipcode
%type<str> NAMETOKEN NAME_INITIAL_TOKEN IDENTIFIERTOKEN
%type<str> SRTOKEN JRTOKEN ROMANTOKEN
%type<str> COMMATOKEN EOLTOKEN
%type<str> INTTOKEN DASHTOKEN HASHTOKEN

%%

 //Grammar Rules
postaladdresses: addressblock EOLTOKEN postaladdresses
 | addressblock;

addressblock: namepart streetaddress locationpart;

namepart: personalpart lastname suffixpart EOLTOKEN {fprintf(stderr, s.serr);
   strcpy(s.serr, ""); 
}
| personalpart lastname EOLTOKEN {fprintf(stderr, s.serr);
   strcpy(s.serr, "");
 }

| error EOLTOKEN {
  //If bad name part, go to end of line and print out error message
     fprintf(stdout, "Bad name-part ... skipping to newline\n");
     fprintf(stderr, s.serr);
 };

//Get first name
personalpart: NAMETOKEN {
  strcpy(s.serr, ""); 
 strcpy(s.temp, "<FirstName>"); 
strcat(s.serr, s.temp);
 strcpy(s.temp, $1);
 strcat(s.serr, s.temp); 
 strcpy(s.temp, "</FirstName>\n");  
 strcat(s.serr, s.temp);
 }
//Get first initial
| NAME_INITIAL_TOKEN {
  strcpy(s.serr, ""); 
  strcpy(s.temp, "<FirstName>");
  strcat(s.serr, s.temp);
  strcpy(s.temp, $1);
  strcat(s.serr, s.temp);
  strcpy(s.temp, "</FirstName>\n");
  strcat(s.serr, s.temp);
 }
;

//Get last name
lastname: NAMETOKEN {
  strcpy(s.temp, "<LastName>");
  strcat(s.serr, s.temp);
  strcpy(s.temp, $1);
  strcat(s.serr, s.temp);
  strcpy(s.temp, "</LastName>\n");
  strcat(s.serr, s.temp);
}
;
//Get suffix (three types)
suffixpart: SRTOKEN {
  strcpy(s.temp, "<Suffix>");
  strcat(s.serr, s.temp);
  strcpy(s.temp, $1);
  strcat(s.serr, s.temp);
  strcpy(s.temp, "</Suffix>\n");
  strcat(s.serr, s.temp);
 }
   | JRTOKEN {
     strcpy(s.temp, "<Suffix>");
     strcat(s.serr, s.temp);
     strcpy(s.temp, $1);
     strcat(s.serr, s.temp);
     strcpy(s.temp, "</Suffix>\n");
     strcat(s.serr, s.temp);
     }   
| ROMANTOKEN {
       strcpy(s.temp, "<Suffix>");
       strcat(s.serr, s.temp);
       strcpy(s.temp, $1);
       strcat(s.serr, s.temp);
       strcpy(s.temp, "</Suffix>\n");
       strcat(s.serr, s.temp);
     };
 streetaddress: streetnumber streetname INTTOKEN EOLTOKEN {
   strcpy(s.temp, "<AptNum>");
   strcat(s.serr, s.temp);
   strcpy(s.temp, $3);
   strcat(s.serr, s.temp);
   strcpy(s.temp, "</AptNum>\n");
   strcat(s.serr, s.temp);
   fprintf(stderr, s.serr);
}
 | streetnumber streetname HASHTOKEN INTTOKEN EOLTOKEN {
   strcpy(s.temp, "<AptNum>");
   strcat(s.serr, s.temp);
   strcpy(s.temp, $4);
   strcat(s.serr, s.temp);
   strcpy(s.temp, "</AptNum>\n");
   strcat(s.serr, s.temp);
   fprintf(stderr, s.serr);
}
 | streetnumber streetname EOLTOKEN {
   fprintf(stderr, s.serr);
   strcpy(s.serr, "");
} 
| error EOLTOKEN {
  //If bad address line, go to end of line and print out error message  
    fprintf(stdout, "Bad address_line ... skipping to newline\n");
    fprintf(stderr, s.serr);
 };

//Get street number
streetnumber: INTTOKEN {
  strcpy(s.serr, "");
strcpy(s.temp, "<HouseNumber>");
   strcat(s.serr, s.temp);
   strcpy(s.temp, $1);
   strcat(s.serr, s.temp);
   strcpy(s.temp, "</HouseNumber>\n");
   strcat(s.serr, s.temp);
}
;
//Get house number
| IDENTIFIERTOKEN { 
 strcpy(s.serr, "");
   strcpy(s.temp, "<HouseNumber>");
   strcat(s.serr, s.temp);
   strcpy(s.temp, $1);
   strcat(s.serr, s.temp);
   strcpy(s.temp, "</HouseNumber>\n");
   strcat(s.serr, s.temp);
  };

//Get street name
streetname: NAMETOKEN {
   strcpy(s.temp, "<StreetName>");
   strcat(s.serr, s.temp);
   strcpy(s.temp, $1);
   strcat(s.serr, s.temp);
   strcpy(s.temp, "</StreetName>\n");
   strcat(s.serr, s.temp);
 };

locationpart: townname COMMATOKEN statecode zipcode EOLTOKEN {
  fprintf(stderr, s.serr);
  strcpy(s.serr, "");
}
     | error EOLTOKEN {
       //If bad location part, go to end of line and print out error message  
      	 fprintf(stdout, "Bad location_part ... skipping to newline\n");
	 fprintf(stderr, s.serr);
       }
 ;

//Get town name
townname: NAMETOKEN {
   strcpy(s.serr, "");
   strcpy(s.temp, "<City>");
   strcat(s.serr, s.temp);
   strcpy(s.temp, $1);
   strcat(s.serr, s.temp);
   strcpy(s.temp, "</City>\n");
   strcat(s.serr, s.temp);
 }
;

//Get state
statecode: NAMETOKEN {
   strcpy(s.temp, "<State>");
   strcat(s.serr, s.temp);
   strcpy(s.temp, $1);
   strcat(s.serr, s.temp);
   strcpy(s.temp, "</State>\n");
   strcat(s.serr, s.temp);
 }
;

//Get zip code
zipcode: INTTOKEN DASHTOKEN INTTOKEN {
  strcpy(s.temp, "<Zip5>");
  strcat(s.serr, s.temp);
  strcpy(s.temp, $1);
  strcat(s.serr, s.temp);
  strcpy(s.temp, "</Zip5>\n");
  strcat(s.serr, s.temp);
  strcpy(s.temp, "<Zip4>");
  strcat(s.serr, s.temp);
  strcpy(s.temp, $3);
  strcat(s.serr, s.temp);
  strcpy(s.temp, "</Zip4>\n\n");
  strcat(s.serr, s.temp);
 }
|  INTTOKEN { 
   strcpy(s.temp, "<Zip5>");
   strcat(s.serr, s.temp);
   strcpy(s.temp, $1);
   strcat(s.serr, s.temp);
   strcpy(s.temp, "</Zip5>\n\n");
   strcat(s.serr, s.temp); }
;

%%

void yyerror (char const *s) {
 }
