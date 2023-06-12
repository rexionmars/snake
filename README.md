[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![](https://img.shields.io/github/languages/count/rexionmars/snake-lang?color=red)
![](https://img.shields.io/github/issues-pr/rexionmars/snake-lang)
![](https://img.shields.io/github/issues/rexionmars/snake-lang?color=pink)
![](https://img.shields.io/github/issues-pr/rexionmars/snake-lang?color=orange)

<img src="thumbnail/snake_banner.jpg" alt="Snake logo">
SNAKE is a Concatenative Stack-Oriented Programming Language.
This will be updated soon

<!-- ## Compilation target for platforms
<img src="thumbnail/target_compile.jpg" alt="Snake Target Compile"> -->

## Main characteristics
- [x] Compiled
- [x] Native
- [x] Stack-based

## Quick Start
```sh
$ git clone https://github.com/rexionmars/snake.git
```
```sh
$ cd snake
```

## Folder Structure
```lua
docs/refs/
  |
  +-- Documentations and references
  
container/
  |
  +-- Standard scripts from translate code (temporary)
  
snake.py
  |
  +-- This file is the principal and contain base functions

```
## SNAKE usage
Sanake has two modes of operation, the first mode to Simulate the program, and the second mode to Compile the program.<br><br>
SNAKE without parameters returns the help menu
```sh
$ ./snake.py
```
simulate program
```sh
$ ./snake.py run <args>
```
or compile the program x86_64 Linux
```sh
$ ./snake.py compile <args>
```
this will generate an x86_64 Linux executable, in the tests folder
```sh
$ cd tests && ./output
```

## Your first Hello World in SNAKE (in initial state)
A simple example using PUSH, PLUS, MINUS, DUMP<br>
Use your favorite editor, i love neovim
```sh
$ nvim sun.snake
```
Example 1: sun two numbers
```sh
49 99 + .
```
Example 2: subtrac two numbers
```sh
13 9 - .
```
|

## Contributors
![GitHub Contributors Image](https://contrib.rocks/image?repo=rexionmars/snake-lang)
