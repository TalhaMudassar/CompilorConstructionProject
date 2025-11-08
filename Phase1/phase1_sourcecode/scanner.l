%option noyywrap
%option yylineno

%{
#include <stdio.h>
#include <string.h>

void print_token(const char *type) {
    printf("Line %d: %s -> %s\n", yylineno, type, yytext);
}

void report_error(const char *msg) {
    fprintf(stderr, "Line %d: ERROR -> %s (%s)\n", yylineno, yytext, msg);
}

extern FILE *yyin;
%}

/* Regular definitions */
DIGIT       [0-9]
LETTER      [A-Za-z]
ID_START    [A-Za-z_]
ID_CONT     [A-Za-z0-9_]
INT         {DIGIT}+
FLOAT       {INT}"."{DIGIT}+
EXPONENT    {INT}(\.{DIGIT}+)?[eE][+-]?{INT}

/* Punjabi-style punctuations */
PUNC_LBLOCK  ":::"
PUNC_RBLOCK  ":::;"
PUNC_END     "~>"
PUNC_SEP     "<>"

/* Punjabi-style operators */
OP_EQUAL     "<->"
OP_NOTEQ     "<!>"
OP_ADDASSIGN "<+>"
OP_GREATER   "+>"
OP_LESS      "<+"
OP_INC       "++>"

/* Standard operators */
OP_ASSIGN    "="
OP_PLUS      "+"
OP_MINUS     "-"
OP_MULT      "*"
OP_DIV       "/"
OP_MOD       "%"
OP_AND       "&&"
OP_OR        "||"
OP_LT        "<"
OP_GT        ">"

%%


[ \t\r]+      { /* skip */ }
\n            { /* yylineno auto-increments */ }


"//".*        { /* skip single-line comment */ }
"/*"([^*]|\*+[^*/])*\*+\/ { 
                char *p; 
                for (p=yytext; *p; ++p) if (*p=='\n') yylineno++;
              }


"fher"       { print_token("KW_fher"); }
"nahiTa"     { print_token("KW_nahiTa"); }
"jadTak"     { print_token("KW_jadTak"); }
"likh"       { print_token("KW_likh"); }
"dass"       { print_token("KW_dass"); }
"morjaa"     { print_token("KW_morjaa"); }
"kaam"       { print_token("KW_kaam"); }
"chakkar"    { print_token("KW_chakkar"); }
"rok"        { print_token("KW_rok"); }
"jaari"      { print_token("KW_jaari"); }
"nava"       { print_token("KW_nava"); }
"class"      { print_token("KW_class"); }
"dekh"       { print_token("KW_dekh"); }
"halat"      { print_token("KW_halat"); }
"mukao"      { print_token("KW_mukao"); }


\"([^\\\n\"]|\\.)*\"   { print_token("STRING_LITERAL"); }
\'([^\\\n\']|\\.)\'    { print_token("CHAR_LITERAL"); }
\"([^\\\n\"]|\\.)*     { report_error("unterminated string"); }
\'([^\\\n\']|\\.)*     { report_error("unterminated character"); }


{OP_ADDASSIGN}  { print_token("OP_ADDASSIGN"); }
{OP_EQUAL}      { print_token("OP_EQUAL"); }
{OP_NOTEQ}      { print_token("OP_NOTEQ"); }
{OP_INC}        { print_token("OP_INC"); }
{OP_GREATER}    { print_token("OP_GREATER"); }
{OP_LESS}       { print_token("OP_LESS"); }
{OP_AND}        { print_token("OP_AND"); }
{OP_OR}         { print_token("OP_OR"); }
{OP_ASSIGN}     { print_token("OP_ASSIGN"); }
{OP_PLUS}       { print_token("OP_PLUS"); }
{OP_MINUS}      { print_token("OP_MINUS"); }
{OP_MULT}       { print_token("OP_MULT"); }
{OP_DIV}        { print_token("OP_DIV"); }
{OP_MOD}        { print_token("OP_MOD"); }
{OP_LT}         { print_token("OP_LT"); }
{OP_GT}         { print_token("OP_GT"); }


{PUNC_RBLOCK}   { print_token("PUNC_RBLOCK"); }
{PUNC_LBLOCK}   { print_token("PUNC_LBLOCK"); }
{PUNC_END}      { print_token("PUNC_END"); }
{PUNC_SEP}      { print_token("PUNC_SEP"); }


"("             { print_token("LPAREN"); }
")"             { print_token("RPAREN"); }
"."             { print_token("DOT"); }
":"             { print_token("COLON"); }
";"             { print_token("SEMICOLON"); }
","             { print_token("COMMA"); }


{EXPONENT}      { print_token("NUMBER_EXPONENT"); }
{FLOAT}         { print_token("NUMBER_FLOAT"); }
{INT}           { print_token("NUMBER_INTEGER"); }


{ID_START}{ID_CONT}*  { print_token("IDENTIFIER"); }



[@#\$][A-Za-z0-9_]*   { report_error("invalid identifier"); }


.                     { report_error("invalid token"); }

%%

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *f = fopen(argv[1], "r");
        if (!f) { fprintf(stderr, "ERROR: Could not open %s\n", argv[1]); return 1; }
        yyin = f;
    }
    yylex();
    return 0;
}
