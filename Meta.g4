grammar Meta;

// n-level language: concrete and abstract
prog
    : body EOF
    ;

body: (fullDecl (';' fullDecl)*)
    ;

fullDecl
    : metaName nameDef (':' exp)? ('=' exp)?
    |
    ;

exp
    : '{' body '}'  // declExpression
    | '{' body '}' '=>' exp // lambda; abstractly this is "let"
                            // solve: how this combines with generics
                            // idea: class A : { arg T } => { body } = ...
                            //       (but the scope of T is abstract only)
                            // maybe the scoping is related to erasure.
// boring stuff here:
    | name
    | exp BINOP exp
    | UNOP exp
    | '(' exp ')'
    | exp '(' (exp (',' exp)*)? ')'
    | exp '[' exp ']'
    | INT
    | STRING
    ;

name: ID ;
metaName : ID ;
nameDef : ID ;


// LEXER
ID: [a-zA-Z_][a-zA-Z_0-9]* ;
INT: ([1-9][0-9]* | [0]) ;
BINOP: '=' | '<' | '>' | '+' | '-' | '*' | '/' | '&' | '|' ;
UNOP: '-' | '!' | '~' ;
STRING: '"' .*? '"' ;
BlockComment : '/*' .*? '*/' -> skip ;
LineComment : '//' ~[\n]* -> skip ;
WS : [ \t\r\n]+ -> skip;
