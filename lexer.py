#!/bin/python3

def find_collumn(line, start, predicate) -> int:
    while start < len(line) and not predicate(line[start]):
        start += 1
    return start

def lexer_line(line):
    collumn = find_collumn(line, 0, lambda x: not x.isspace())

    while collumn < len(line):
        collumn_end = find_collumn(line, collumn, lambda x: x.isspace())
        yield (collumn, line[collumn:collumn_end])
        collumn = find_collumn(line, collumn_end, lambda x: not x.isspace())

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

