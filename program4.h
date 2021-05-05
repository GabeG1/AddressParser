/*                                                                              
 *Filename        program4.h                                                   
 *Date            3/27/19                                                        
 *Author          Gabriel Goldstein                                             
 *Email           gjg180000@utdallas.edu                                        
 *Course          CS 3377.502 Spring 2019                                       
 *Version         1.0                                                           
 *Copyright 2019, All Rights Reserved                                           
 *                                                                              
 *Description                                                                   
 *         Header file containing certain protorypes and variables to be defined later                                                       
 *      
 */


#ifndef __PROG4__
#define __PROG4__

//struct to gather information from the parser and scanner
typedef struct stu
{
  char sout[1024];
  char serr[1024];
  char serr1[1024];
  char temp[100];
  char tokenType[1024]; 
} s_struct;

extern char* yytext;
void  yyerror(char const *s);
int  yylex(void);
s_struct s;
#endif //__PROG4__
