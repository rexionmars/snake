#include <stdio.h>

#define SV_IMPLEMENTATIO
#include "./sv.h"

int main() {
    String_View source = SV("34 35 + . dadad");

    sv_trim_left(source);
    while (source.count > 0) {
    }

    return 0;
}
