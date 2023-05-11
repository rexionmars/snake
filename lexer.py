def strip_collumn(line: list, collumn: int) -> int:
    while collumn < len(line) and line[collumn].__isspace():
        collumn += 1
    return collumn

def chop_world(): ...

def lexer_line(line):
    collumn = strip_collumn(line, 0)
    while collumn < len(line):
        collumn_end = line.find(' ', collumn)

        if collumn_end < 0:
            collumn_end = len(line)
        elif collumn_end == 0:
            assert False, 'Unreachable, strip_collumn must ensure that this never happens'

        yield (collumn, line[collumn:collumn_end])
        collumn = strip_collumn(line, collumn_end)

def lexer_file(file_parh):
    """
    This function is created for check analizis lexcal
    """

    with open(file_parh, 'r') as file:
        return [
            (file_parh, row, line, col, token)
            for (row, line) in enumerate(file.readlines())
            for (col, token) in lexer_line(line)
        ]
