%option noyywrap
%option yylineno

%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

FILE *tokFile;
FILE *errFile;

int total_tokens = 0;
int count_identifier = 0;
int count_integer = 0;
int count_float = 0;
int count_exponent = 0;
int count_string = 0;
int count_char = 0;
int count_keyword = 0;
int count_operator = 0;
int count_punct = 0;
int count_error = 0;

void print_token(const char *type) {
    fprintf(tokFile, "Line %d: %-16s -> %s\n", yylineno, type, yytext);
    total_tokens++;

    if (!strcmp(type,"IDENTIFIER")) count_identifier++;
    else if (!strcmp(type,"NUMBER_INTEGER")) count_integer++;
    else if (!strcmp(type,"NUMBER_FLOAT")) count_float++;
    else if (!strcmp(type,"NUMBER_EXPONENT")) count_exponent++;
    else if (!strcmp(type,"STRING_LITERAL")) count_string++;
    else if (!strcmp(type,"CHAR_LITERAL")) count_char++;
    else if (!strncmp(type,"KW_",3)) count_keyword++;
    else if (!strncmp(type,"OP_",3)) count_operator++;
    else if (!strncmp(type,"PUNC_",5)) count_punct++;
}

void report_error(const char *msg) {
    fprintf(errFile, "Line %d: ERROR -> %s : %s\n", yylineno, msg, yytext);
    count_error++;
    total_tokens++;
}

extern FILE *yyin;
%}

DIGIT       [0-9]
LETTER      [A-Za-z]
ID_START    [A-Za-z_]
ID_CONT     [A-Za-z0-9_]
INT         {DIGIT}+
FLOAT       {INT}"."{DIGIT}+
EXPONENT    {INT}(\.{DIGIT}+)?[eE][+-]?{INT}

PUNC_LBLOCK  ":::"
PUNC_RBLOCK  ":::;"
PUNC_END     "~>"
PUNC_SEP     "<>"

OP_ADDASSIGN "<+>"
OP_EQUAL     "<->"
OP_NOTEQ     "<!>"
OP_INC       "++>"
OP_GREATER   "+>"
OP_LESS      "<+"
OP_ASSIGN_PUNJ "<-"

OP_PLUS       "\+"
OP_MINUS      "-"
OP_MULT       "\*"
OP_DIV        "/"
OP_MOD        "%"
OP_AND        "&&"
OP_OR         "\|\|"
OP_LT         "<"
OP_GT         ">"
OP_EQ_C       "=="
OP_NEQ_C      "!="
OP_INC_C      "\+\+"
OP_ADDASSIGN_C "\+="

%%

[ \t\r]+      { }
\n            { }

"//".*        { }

"/*"([^*]|\*+[^*/])*\*+\/ {
    char *p; for (p=yytext;*p;p++) if (*p=='\n') yylineno++;
}

"/*"([^*]|\*+[^*/])*$ { report_error("Unterminated block comment"); }

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

"if"        { report_error("Use 'fher'"); }
"else"      { report_error("Use 'nahiTa'"); }
"while"     { report_error("Use 'jadTak'"); }
"for"       { report_error("Use 'kaam'"); }
"do"        { report_error("Use 'chakkar'"); }
"break"     { report_error("Use 'rok'"); }
"continue"  { report_error("Use 'jaari'"); }
"new"       { report_error("Use 'nava'"); }
"switch"    { report_error("Use 'dekh'"); }
"case"      { report_error("Use 'halat'"); }
"default"   { report_error("Use 'mukao'"); }
"return"    { report_error("Use 'morjaa'"); }
"cin"       { report_error("Use 'likh'"); }
"cout"      { report_error("Use 'dass'"); }

{OP_ADDASSIGN}  { print_token("OP_AddAssign"); }
{OP_EQUAL}      { print_token("OP_Equal"); }
{OP_NOTEQ}      { print_token("OP_Not_Equal"); }
{OP_INC}        { print_token("OP_Increment"); }
{OP_GREATER}    { print_token("OP_Greater"); }
{OP_LESS}       { print_token("OP_Less"); }


{OP_EQ_C}       { report_error("Use '<->'"); }
{OP_NEQ_C}      { report_error("Use '<!>'"); }
{OP_INC_C}      { report_error("Use '++>'"); }


{OP_PLUS}       { print_token("OP_PLUS"); }
{OP_MINUS}      { print_token("OP_MINUS"); }
{OP_MULT}       { print_token("OP_MULT"); }
{OP_DIV}        { print_token("OP_DIV"); }
{OP_MOD}        { print_token("OP_MOD"); }
{OP_AND}        { print_token("OP_AND"); }
{OP_OR}         { print_token("OP_OR"); }
"<"             { print_token("OP_LT"); }
">"             { print_token("OP_GT"); }

{PUNC_LBLOCK}   { print_token("PUNC_LBLOCK"); }
{PUNC_RBLOCK}   { print_token("PUNC_RBLOCK"); }
{PUNC_END}      { print_token("PUNC_END"); }
{PUNC_SEP}      { print_token("PUNC_SEP"); }

"{"             { report_error("Use ':::'"); }
"}"             { report_error("Use ':::;'"); }
";"             { report_error("Use '~>'"); }

"("             { print_token("LPAREN"); }
")"             { print_token("RPAREN"); }
","             { print_token("COMMA"); }
":"             { report_error("Not allowed ':'"); }
"."             { print_token("DOT"); }

\"([^\\\n\"]|\\.)*\"  { print_token("STRING_LITERAL"); }
\'([^\\\n\']|\\.)\'   { print_token("CHAR_LITERAL"); }

\"([^\\\n\"]|\\.)*    { report_error("Unterminated string"); }
\'([^\\\n\']|\\.)*    { report_error("Unterminated char"); }

{EXPONENT}      { print_token("NUMBER_EXPONENT"); }
{FLOAT}         { print_token("NUMBER_FLOAT"); }
{INT}           { print_token("NUMBER_INTEGER"); }

{ID_START}{ID_CONT}* { print_token("IDENTIFIER"); }

[@#\$][A-Za-z0-9_]* { report_error("Invalid identifier"); }

. { report_error("Invalid token"); }

%%

int main(int argc, char **argv)
{
    tokFile = fopen("tokens.txt","w");
    errFile = fopen("errors.log","w");

    if (argc > 1) {
        FILE *f = fopen(argv[1],"r");
        if (!f) return 1;
        yyin = f;
    }

    yylex();

    fprintf(tokFile,"\n========= SUMMARY =========\n");
    fprintf(tokFile,"Total tokens: %d\n", total_tokens);
    fprintf(tokFile,"Identifiers: %d\n", count_identifier);
    fprintf(tokFile,"Integers: %d\n", count_integer);
    fprintf(tokFile,"Floats: %d\n", count_float);
    fprintf(tokFile,"Exponents: %d\n", count_exponent);
    fprintf(tokFile,"Strings: %d\n", count_string);
    fprintf(tokFile,"Chars: %d\n", count_char);
    fprintf(tokFile,"Keywords: %d\n", count_keyword);
    fprintf(tokFile,"Operators: %d\n", count_operator);
    fprintf(tokFile,"Punctuation: %d\n", count_punct);
    fprintf(tokFile,"Errors: %d\n", count_error);

    fclose(tokFile);
    fclose(errFile);
    return 0;
}
