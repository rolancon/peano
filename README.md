# Peano
Peano numbers and math, based on [Peano axioms](https://en.wikipedia.org/wiki/Peano_axioms); see especially the section on [Defining arithmetic operations and relations](https://en.wikipedia.org/wiki/Peano_axioms#Defining_arithmetic_operations_and_relations). This means the FPU (floating-point unit) on your device is never used, all calculation is done using the successor (and predecessor) function on the string-based representation of numbers.

The numbers have to be postitive integers (whole numbers from 0 upwards), and must be separared from the operators with spaces, but can be of arbitrary length. There is no support for negative numbers, therefore any subtraction that results in a negative number (like _0 - 1_) is shown as _0_.

There are compiled binaries for Windows, macOS and Linux (in the _bin_ directory).

When you call _peano_ without argument, it will show a **>** prompt, after which you can type either an addition, a subtraction, a multiplication or an exponentiation:

    > 10 + 10
    20
    > 10 - 10
    00
    > 10 * 10
    100
    > 10 ** 10
    10000000000
    >

Simply pressing the Enter (Return) key will exit your session.

When you include the expression as an argument to the _peano_ executable it will show the result:

    >peano 10 + 10
    20
