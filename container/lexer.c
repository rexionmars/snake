#include <stdio.h>

#define SV_IMPLEMENTATION
#include "./sv.h"

#define red "\033[0;31m"
#define reset "\033[0m"


int main()
{
    String_View source = SV("34 35 + . asf");
    const char *start = source.data;

    source = sv_trim_left(source);
    while (source.count > 0)
    {
        String_View token = sv_chop_by_delim(&source, ' ');
        size_t col = token.data - start;

        printf("Token: %s" SV_Fmt " [%zu]%s\n", red, SV_Arg(token), col, reset);
        source = sv_trim_left(source);
    }

    return 0;
}
