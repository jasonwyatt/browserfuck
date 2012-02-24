# BrainfuckScript

The goal of this project is to be ridiculous. I do not suggest you actually use Brainfuck to script your DOM, as it is a horrible language. It is fun, however, to play with.  Enjoy.

## Compiling the Compiler

1. Install node.js and npm
1. `sudo npm install jison -g`
1. `git clone git://github.com/jasonwyatt/BrianfuckScript.git`
1. `cd BrainfuckScript`
1. `jison jison/brainfuck.jison`

## Running the compiler

1. `node brainfuck.js [your brainfuck file] > [output filename.js]`
1. Profit
