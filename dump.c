/*  ____  _   _ __  __ ____
 * |  _ \| | | |  \/  |  _ \
 * | | | | | | | |\/| | |_) |
 * | |_| | |_| | |  | |  __/
 * |____/ \___/|_|  |_|_|
 */

#include <stdio.h>
#include <stdint.h>
#include <unistd.h>

#define BUFFER_CAPACITY 32

void dump(uint64_t x)
{
    /*  CAPACITY = 5
     *  index  =   0
     *   0 1 2 3 4 5
     *   CAPACITY - index - 1 = 4
     */
    char buffer[32];
    size_t buffer_size = 0;

    while (x) {
        buffer[sizeof(buffer) - buffer_size - 1] = (x % 10 + '0');
        buffer_size++;
        x /= 10;
    }
    write(1, &buffer[sizeof(buffer) - buffer_size], buffer_size);
}

int main()
{
    dump(69420);
    return 0;
}
