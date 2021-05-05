 #                                                                                                                                                                                                         
 #Filename        Makefile                                                                                                                                                                                 
 #Date            3/27/19                                                                                                                                                                                  
 #Author          Gabriel Goldstein                                                                                                                                                                        
 #Email           gjg180000@utdallas.edu                                                                                                                                                                   
 #Course          CS 3377.502 Spring 2019                                                                                                                                                                  
 #Version         1.0                                                                                                                                                                                      
 #Copyright 2019, All Rights Reserved                                                                                                                                                                      
 #                                                                                                                                                                                                         
 #Description                                                                                                                                                                                              
 #        Compile yacc file, link with lex file and c file to make executable                                                                                                                              
 #                                                                                                                                                                                                          

CC = gcc
CPPFLAGS = -Wall
SRCS = lex.yy.c yacc.tab.c
OBJS = lex.yy.o yacc.tab.o program4.o
LEX = flex

#Create phony targets all and clean                                                                                                                                                                        
.PHONY: all clean

#Call the executable program4 to be built, as well as the symbolic links scanner and parser                                                                                                                
all: program4 scanner parser

#Remove any object files, files with ~, and the executable file                                                                                                                                            
clean:
	rm -f $(OBJS) $(SRCS) *~ program4 yacc.tab.h \#* scanner parser

#Symbolic link scanner that points to program4                                                                                                                                                             
scanner: program4
	ln -s ./program4 scanner

#Symbolic link parser that points to program4                                                                                                                                                              
parser: program4
	ln -s ./program4 parser

#Link the object files to make the executable file program4                                                                                                                                                
program4: $(OBJS)
	$(CC) -o program4  $(OBJS)

#Compile program4.c to get program4.o                                                                                                                                                                      
program4.o: program4.c program4.h
	$(CC) -c program4.c -Wall -Werror

#Compile the lex.yy.c file to get lex.yy.o                                                                                                                                                                 
lex.yy.o: lex.yy.c
	$(CC) $(FLAGS) -c lex.yy.c -o lex.yy.o -Wall -Werror

#Compile yacc.tab.c to get yacc.tab.o                                                                                                                                                                     
yacc.tab.o: yacc.tab.c
	$(CC) -c yacc.tab.c -o yacc.tab.o -Wall -Werror

#Flex takes the lexical analyzer and puts it into c code (lex.yy.c)                                                                                                                                       
lex.yy.c: lex.l program4.h yacc.tab.c yacc.tab.h
	$(LEX) lex.l

#Bison takes grammar rules and puts it into c code (yacc.tab.c)                                                                                                                                           
yacc.tab.c: yacc.y program4.h
	bison -k --defines=yacc.tab.h yacc.y

