## Tokenization
ref:
    https://www.univ-orleans.fr/lifo/Members/Mirian.Halfeld/Cours/TLComp/l3-0708-LexA.pdf<br>
    https://www.techopedia.com/definition/13698/tokenization#:~:text=Tokenization%20is%20the%20act%20of,like%20punctuation%20marks%20are%20discarded<br>
    https://www.cs.man.ac.uk/~pjj/farrell/comp3.html<br>
    
## Basics Concept of Anatomy of a Compiler
A compiler is a tool that translates a program from one language to another language. An interpreter is a tool that takes a program and executes it. In the first case the program often comes from a file on disk and in the second the program is sometimes stored in a RAM buffer, so that changes can be made quickly and easily through an integrated editor. This is often the case in BASIC interpreters and calculator programs. We will refer to the source of the program, whether it is on disk or in RAM, as the input stream.
Regardless of where the program comes from it must first pass through a Tokenizer, or as it is sometimes called, a Lexer. The tokenizer is responsible for dividing the input stream into individual tokens, identifying the token type, and passing tokens one at a time to the next stage of the compiler.
The next stage of the compiler is called the Parser. This part of the compiler has an understanding of the language's grammar. It is responsible for identifying syntax errors and for translating an error free program into internal data structures that can be interpreted or written out in another language.
The data structure is called a Parse Tree, or sometimes an Intermediate Code Representation. The parse tree is a language independent structure, which gives a great deal of flexibility to the code generator. The lexer and parser together are often referred to as the compiler's front end. The rest of the compiler is called the back end. Due to the language independent nature of the parse tree, it is easy, once the front end is in place, to replace the back end with a code generator for a different high level language, or a different machine language, or replacing the code generator all together with an interpreter. This approach allows a compiler to be easily ported to another type of computer, or for a single compiler to produce code for a number of different computers (cross compilation).
Sometimes, especially on smaller systems, the intermediate representation is written to disk. This allows the front end to be unloaded from RAM, and RAM is not needed for the intermediate representation. This has two disadvantages: it is slower, and it requires that the parse tree be translated to a form that can be stored on disk.
The next step in the process is to send the parse tree to either an interpreter, where it is executed, or to a code generator preprocessor. Not all compilers have a code generator preprocessor. The preprocessor has two jobs. The first is to break any expressions into their simplest components. For example, the assignment a := 1 + 2 * 3 would be broken into temp := 2 * 3; a := 1 + temp; Such expressions are called Binary Expressions. Such expressions are necessary for generating assembler language code. Compilers that translate from one high level language to another often do not contain this step. Another task of the code generator preprocessor is to perform certain machine independent optimizations.
After preprocessing, the parse tree is sent to the code generator, which creates a new file in the target language. Sometimes the newly created file is then post processed to add machine dependent optimizations.
Figure 1 shows graphically the different parts of a compiler;<br>
![Sonny and Mariel high fiving.](https://www.cs.man.ac.uk/~pjj/farrell/cmpgif01.gif)

## The Tokenizer
The job of the tokenizer is to read tokens one at a time from the input stream and pass the tokens to the parser. The heart of the tokenizer is the following type:
```pascal
token_type_enum = (glob_res_word, 
                   con_res_word,
                   reserved_sym,
                   identifier, 
                   string_type,
                   int_type, 
                   real_type);

record Token_Type is
  begin
    infile        : text;
    cur_str       : array [1..80] of char;
    cur_str_len   : integer;

    cur_line      : integer;
    cur_pos       : integer;

    type_of_token : token_type_enum;
    read_string   : char [1..30] of char;
    cap_string    : char [1..30] of char;
    int_val       : integer;
    float_val     : real;
    glob_res_word : glob_res_word_type;
    con_res_word  : con_res_word_type;
    res_sym       : res_sym_type;
  end; (* Token *)
```
A variable of this type is used to hold the current token. The field infile is the input stream the program being parsed is held in (for those that do not know Pascal, text files have the type text). The next field is the current line being parsed. It is more efficient to read files a chunk at a time rather than a character at a time, so it is standard practice to add a field to hold an entire string to the token. Cur_str_len gives the length of the current string;

If the stream is from a RAM buffer then these two fields can be replaced with a pointer to the correct position in the buffer.

The cur_line and cur_pos fields hold the current line number and current position in that line. This data is used by the parser to indicate where errors occur.

Glob_res_word_type, con_res_word_type, and res_sym are enumerations. The enumerations are not given here because they are language specific (we should at least pay lip service to being language independent here) and they can be quite large. The tokenizer handles context sensitive reserved words like a separate group of globally reserved words. It is up to the parser to decide what context is currently being parsed and whether a context sensitive reserved word should be treated as a reserved word or an identifier.

There is an alternate way to handle context sensitive reserved words. The tokenizer can handle all identifiers simply as identifiers, but provide additional procedures to determine if an identifier is a globally reserved word or a context sensitive reserved word. Then when the parser reads an identifier it queries the tokenizer as to whether the identifier is one or the other. Which ever method is used, context sensitive reserved words mean more work for the parser. This is why it is preferred to make all reserved words global.

Read_string contains the token string as it was read from the input stream, cap_stream contains the token string after it has been capitalized. That is these strings contain only the token. When the token type is reserved word, identifier, or string the correct value will be in one of these fields. When the token type is integer or real a string representation of value will be found here. Since Pascal is not case sensitive all strings will be capitalized as they are read. This will facilitate locating variables and procedures in a case independent way. Sometimes, however, the uncapitalized string is required, such as when a string constant is encountered in the input stream.

Int_val and float_val will contain the correct value when either an integer or real are read. Glob_res_word, con_res_word and res_sym are enumerations that contain all possible globally reserved words, context sensitive reserved words and reserved symbols, respectively.

The tokenizer next must provide several procedures to manipulate tokens. An initialization procedure is usually needed to open the input stream and find the first token. The parser will need a procedure to read the next token on command. This procedure is shown below. The procedure looks long and scary, but it is very straight forward. Most of the space is taken up with comments, and there is nothing tricky in the code itself.

procedure Advance_Token (var Token : Token_Type);
