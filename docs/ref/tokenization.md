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
```pascal
procedure Advance_Token (var Token : Token_Type);

var
  read_str_idx : integer;
  i : integer;

begin
  with token do
    begin
      (* Clear strings *)
      (* You may have to provide the following     *)
      (* procedure.  Check your compiler's manuals *)
      (* for how to do this                        *)
      clear_string (cur_str);
      clear_string (read_string);
      clear_string (cap_string);

      (* Find start of next token *)
      while (cur_str[cur_pos] = ' ') do
        begin
          (* if end of line, get next line *)
          if (cur_pos > cur_str_len) then
            begin
              readln (infile, cur_str);
              (* You may have to provide the following     *)
              (* procedure.  Check your compiler's manuals *)
              (* for how to do this                        *)
              find_string_length (cur_str_len, cur_str);
              cur_pos := 1;
            end; {if (cur_pos > cur_str_len)}

            (* if end of file, return end of 
               file reserved symbol *)
            if (eof(infile)) then
              begin
                type_of_token := RESERVED_SYMBOL;
                res_sym       := END_OF_FILE;
                return;
              end; { if (eof(infile)) }
        end; { while (cur_str[cur_pos] = ' ')

      (* copy token to read_string and cap_string *)
      read_str_idx := 1;
      (* you have to provide the function not_delimiter *)
      (* it simply tests the character and returns true *)
      (* if it is not in the set of delimiters          *)
      while (not_delimiter(cur_str[cur_pos])) do
        begin
          read_str[read_str_idx] := cur_str[cur_pos];
          cap_str[read_str_idx]  :=
                            upcase (cur_str[cur_pos]);
          read_str_idx := read_str_idx + 1;
        end; { while (not_delimiter(cur_str[cur_pos])) }

      (* determine token type *)
      (* is token an identifier? *)
      if (cap_string[1] >= 'A') and
         (cap_string[1] <= 'Z') then
        begin
          (* is token a global reserved word? *)

          (* glob_res_word_table is a table (possibly a     *)
          (* binary search tree) of reserved words.         *)
          (* Find_in_table returns the enumeration value    *)
          (* associated with the reserved word if it is a   *)
          (* globally reserved word.  Otherwise it returns  *)
          (* UNDEFINED.                                     *)
          find_in_table(glob_res_word_table, 
                        cap_string, 
                        glob_res_word);
          if NOT (glob_res_word = UNDEFINED) then
            begin
              type_of_token := GLOBAL_RES_WORD;
              return;
            end; { if NOT (glob_res_word = UNDEFINED) }

          (* is token a context sensitive reserved word? *)
          find_in_table(con_res_word_table, 
                        cap_string, 
                        con_res_word);
          if NOT (con_res_word = UNDEFINED) then
            begin
              type_of_token := CONTEXT_RES_WORD;
              return;
            end; { if NOT (con_res_word = UNDEFINED) }

          (* if its not a global reserved word or a context *)
          (* sensitive reserved word, it must be an         *)
          (* identifier                                     *)

          type_of_token := INDENTIFIER;
          return;
        end; { if (cap_string[1] >= 'A') and
                  (cap_string[1] <= 'Z') }

      (* is token a number? *)
      if ((cap_string[1] >= '0') and
          (cap_string[1] <= '9')) or
          (cap_string[1] = '-' then
        (* is token a real or integer? *)
        for i := 2 to read_str_idx do
          if (cap_string[i] = '.') or
             (cap_string[i] = 'E') then
            begin
              (* once again, you may have to provide *)
              (* the following function to translate *)
              (* a string to a real                  *)
              float_val     := string_to_real(cap_string);
              type_of_token := real_type;
              return;
            end; {if (cap_string[i] = '.') or
                     (cap_string[i] = 'E') }
        else
          begin  
            int_val       := string_to_int(cap_string);
            type_of_token := int_type;
            return;
          end;

      (* is token a string? *)
      if (cap_string[1] = '''') then (* this syntax seems
                                        strange, but it seems to
                                        work! *)
        begin
          type_of_token := string_type;
          return;
        end;

      (* is token a reserved symbol? *)
      find_in_table(res_sym_table, 
                    cap_string, 
                    res_sym);
      if NOT (res_sym = UNDEFINED) then
        begin
          type_of_token := reserved_sym;
          return;
        end;

     (* if the type of token has not been found yet *)
     (* it must be an unknown type                  *)
     (* This is a lexical error                     *)
     type_of_token := UNKNOWN_TOKEN_TYPE;  

   end; { with token do }
end; { procedure advance_token }
```
This procedure is actually only about two and a half pages long, and without comments it would probably be less than two. Some software engineers stress that a procedure should not be more than a page long. Such "engineers" are generally college professors that have never ventured beyond the walls of their ivory towers. In real life a two and a half page procedure is considered not overly long. As long as the entire procedure is on the same logical level, it will be readable and easy to understand.

The general logic of the procedure should be easy to see by reading it (or its comments). First we find the next token. This might involve reading the next line from the input stream. Next we copy the token into read_string and cap_string. Then we set about determining the type of the token. If the token starts with a letter, it is an identifier, global reserved word or context sensitive reserved word. To determine if the identifier is a context sensitive or global reserved word, tables are queried that contain each type of word. If the identifier is found in one of the tables, the associated enumeration is returned.

Note that a very flexible tokenizer could be created by using strings instead of enumerations and keeping the reserved words and symbols in a file. When the tokenizer is initialized the reserved words and symbols can be read into the tables. This way the language the tokenizer works on can be changed by simply changing the files. No source code would need to be changed. The draw back is that the parser needs to perform comparisons. If strings are used instead of enumerations, less efficient string compares would have to be used instead of more efficient comparisons on enumerations.

If the first character of the token is a digit the token is a number, or if the first character is a minus sign the token is a negative number. If the token is a number it might be a real or an integer. If it contains a decimal point or the letter E (which indicates scientific notation) then it is a real, otherwise it is an integer. Note that this could be masking a lexical error. If the file contains a token "9abc" the lexer will turn it into an integer 9. It is likely that any such error will cause a syntax error which the parser can catch, however the lexer should probably be beefed up to look for such things. It will make for more readable error messages to the user.

If the token is not a number it could be a string. Strings in Pascal are identified by single quote marks. And finally, if the token is not a string it must be a reserved symbol. For convenience, the reserved symbols are stored in the same type of table as the global and context sensitive reserved words. If the token is not found in this table it is a lexical error. The tokenizer does not handle errors itself, so it simply notifies the parser that an unidentified token type has been found. The parser will handle the error.
