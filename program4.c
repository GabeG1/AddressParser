/*                                                                              
 *Filename        program4.c                                                       
 *Date            3/27/19                                                        
 *Author          Gabriel Goldstein                                             
 *Email           gjg180000@utdallas.edu                                        
 *Course          CS 3377.502 Spring 2019                                       
 *Version         1.0                                                           
 *Copyright 2019, All Rights Reserved                                           
 *                                                                              
 *Description                                                                   
 *          Call either the scanner or parser, depending on what is put on the command line                                                                    
 *      
 */


#include <stdio.h>
#include <stdlib.h>
#include "yacc.tab.h"
#include "program4.h"
#include <string.h>

int main(int argc, char* argv[])
{
  //If the scanner is called
  if(strcmp(argv[0], "./scanner") == 0)
    {
      fprintf(stdout, "Operating in scan mode\n\n");
      //Call yylex until 0 is returned(end of file reached)
      while(yylex() != 0)
	{
	  //Print out the token type and relevant information pertaining to the token
	  if(strcmp(s.tokenType, "JRTOKEN") == 0){
	    fprintf(stdout, "yylex returned %s token (%d)\n", s.tokenType, JRTOKEN);
	  }
	  else if(strcmp(s.tokenType, "SRTOKEN") == 0){
            fprintf(stdout, "yylex returned %s token (%d)\n", s.tokenType, SRTOKEN);
          }
	  else if(strcmp(s.tokenType, "DASHTOKEN") == 0){
            fprintf(stdout, "yylex returned %s token (%d)\n", s.tokenType, DASHTOKEN);
          }
	  else if(strcmp(s.tokenType, "EOLTOKEN") == 0){
            fprintf(stdout, "yylex returned %s token (%d)\n", s.tokenType, EOLTOKEN);
          }
	  else if(strcmp(s.tokenType, "HASHTOKEN") == 0){
            fprintf(stdout, "yylex returned %s token (%d)\n", s.tokenType, HASHTOKEN);
          }
	  else if(strcmp(s.tokenType, "COMMATOKEN") == 0){
            fprintf(stdout, "yylex returned %s token (%d)\n", s.tokenType, COMMATOKEN);
          }
	  else
	    {
          fprintf(stdout, "yylex returned %s token (%s)\n", s.tokenType, yylval.str);
	    }	
}
    }
  //If parser called
  else if(strcmp(argv[0], "./parser") == 0)
    {
      fprintf(stdout, "Operating in parse mode\n\n");
      //call parser     
 yyparse();
      fprintf(stdout, "\nParse Successful!\n");
    }
  //If neither of above is used to call the executable
  else
    {
      fprintf(stdout, "Program called with wrong name\n\n");
    }
  return 0;
}
