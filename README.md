[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![](https://img.shields.io/github/languages/count/whoisleonardi/snake-lang?color=red)
![](https://img.shields.io/github/issues-pr/whoisleonardi/snake-lang)
![](https://img.shields.io/github/issues/whoisleonardi/snake-lang?color=pink)
![](https://img.shields.io/github/issues-pr/whoisleonardi/snake-lang?color=orange)

<img src="thumbnail/snake_banner.jpg" alt="Snake logo">
SNAKE is a Concatenative Stack-Oriented Programming Language for Computers.
This will be updated soon

## What is a Stack-based programming language?

A stack-based programming language is a language that uses a stack to store and manipulate data during program execution. The stack is a data structure that operates on the Last-In-First-Out (LIFO) principle, that is, the last element inserted into the stack is the first to be removed.

This approach is commonly used in functional programming languages, such as the Forth language and HP's RPL language, which are designed for programming on HP calculators. It is also commonly used in other programming languages, such as PostScript and assembly.

A stack-based programming language is useful in situations where the execution stack is a natural and efficient way to store and manipulate data. For example, it can be used to simplify the implementation of mathematical calculations, which involve a series of operations that are performed on a stack of data. In addition, the stack approach can be used to simplify the flow control of a program, since the stack manipulation can be used to control the execution of subroutines and loops in a very efficient way.

**WARNING! THIS LANGUAGE IS A WORK IN PROGRESS! ANYTHING CAN CHANGE AT ANY MOMENT WITHOUT ANY NOTICE! USE THIS LANGUAGE AT YOUR OWN RISK!**

## Quick started
Sanake has two modes of operation, the first mode to Simulate the program, and the second mode to Compile the program
```sh
$ python3 snake.py run
```
or compile the program
```sh
$ python3 snake.py compile
```
this will generate an x86_64 Linux executable, in the tests folder
```sh
$ cd tests && ./output
```
