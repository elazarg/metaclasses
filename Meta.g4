grammar Meta;

// n-level language: concrete and abstract
prog
    : (fullDecl ';')+ EOF
    ;

fullDecl
    : metaName nameDef (':' exp)? ('=' exp)?
    ;

exp
    : '{' (fullDecl ';')* '}'  // declExpression - the special thing
    | name
    | '[' fullDecl ']' '=>' exp
    | exp BINOP exp
    | UNOP exp
    | '(' exp ')'
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
BINOP: '=' | '<' | '>' | '+' | '-' | '*' | '/' ;
UNOP: '-' ;
STRING: '"' .*? '"' ;
BlockComment : '/*' .*? '*/' -> skip ;
LineComment : '//' ~[\n]* -> skip ;
WS : [ \t\r\n]+ -> skip;
