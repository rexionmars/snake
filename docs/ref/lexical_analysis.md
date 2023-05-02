## Introduction of Lexical Analysis
ref:<br>
    https://www.geeksforgeeks.org/introduction-of-lexical-analysis/<br>
    https://en.wikipedia.org/wiki/Lexical_analysis<br>
    https://stackoverflow.com/questions/2842809/lexers-vs-parsers<br>
    https://clang.llvm.org/doxygen/classclang_1_1Lexer.html<br>
    https://dev.to/cad97/what-is-a-lexer-anyway-4kdo<br>
    https://web.cs.ucdavis.edu/~peisert/teaching/cse131a/lecture_slides/131a_lecture1b.pdf<br>
    https://www.guru99.com/compiler-design-lexical-analysis.html<br>
    https://datacadamia.com/code/compiler/lexer<br>
    https://courses.cs.washington.edu/courses/cse401/01sp/02-lexing.pdf<br>
    
## DEV.TO
The first task when implementing any language (that is already specified) is to turn the source code into some sort of Syntax Tree that's meaningful to the computer, rather than the human-optimized surface language.

This is the task of Parsing. Parsing is a wide and well studied field in computer science, and formally, is the problem of just recognizing if any given string is a member of some language.

Slightly more concretely, parsing is the task of turning a list of symbols into a data structure representing some higher level of structure. In the case of parsing, the set of input symbols are characters†.

Traditionally, parsing of programming languages is split up into two phases: the lexing stage and the parsing stage. In truth, both of these stages are parsers: they both take an input list of symbols and produce a higher level of structure. It's just that the lexer's output is used as the parser's input.

This separation is useful because the lexer's job is simpler than the parser's. The lexer just turns the meaningless string into a flat list of things like "number literal", "string literal", "identifier", or "operator", and can do things like recognizing reserved identifiers ("keywords") and discarding whitespace. Formally, a lexer recognizes some set of Regular languages. A "regular" language is one that can be parsed without any extra state in a single non-backtracking pass. This makes it very efficient: you only have to look at one byte at a time to make decisions, and all of the decisions can even be packed into a decision matrix called a Finite Automaton. If you've ever used a regular expression, you've written a recognizer for a regular language‡.

The parser has the much harder job of turning the stream of "tokens" produced by the lexer into a parse tree representing the structure of the parsed language. The separation of the lexer and the parser allows the lexer to do its job well and for the parser to work on a simpler, more meaningful input than the raw text.

While there are many ways to generate lexers, we'll be implementing our lexer by hand so that the structure of it can be seen. The simplest form of the lexer is fn(&str) -> Token, where Token is a (Kind, Length) pair. That's the API we'll implement, though for convenience we also provide a fn(&str) -> impl Iterator<Item=Token> access point. Note that this is an infallible transform: on unexpected characters we just return an error token.

Let's look at our Tiny-C grammar again to determine what our lexer has to recognize:
```rust
Program = Statement;
Statement =
  | If:{ "if" cond:ParenExpr then:Statement else:{ "else" then:Statement } }
  | While:{ "while" cond:ParenExpr then:Statement }
  | Block:{ "{" then:Statement* "}" }
  | Expr:{ then:Statement? ";" }
  ;
ParenExpr = "(" Expr ")";
Expr =
  | Assign:{ id:Id "=" val:Expr }
  | Test:{ lhs:Expr "<" rhs:Expr }
  | Sum:{ lhs:Expr "+" rhs:Term }
  | Diff:{ lhs:Expr "-" rhs:Term }
  ;
Term =
  | Id:{ 'a'..='z'+ }
  | Int:{ '0'..='9'+ }
  | Expr:ParenExpr
  ;
```
