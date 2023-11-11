# Peano
Peano numbers and math, based on [Peano axioms](https://en.wikipedia.org/wiki/Peano_axioms); see especially the section on [Defining arithmetic operations and relations](https://en.wikipedia.org/wiki/Peano_axioms#Defining_arithmetic_operations_and_relations). This means the FPU (floating-point unit) on your device is never used, all calculation is done using the successor (and predecessor) function on the string-based representation of numbers.

The numbers have to be postitive integers (whole numbers from 0 upwards), and must be separared from the operators with spaces, but can be of arbitrary length. There is no support for negative numbers, therefore any subtraction that results in a negative number (like _0 - 1_) is shown as _0_.

When you use the script version, type either an addition, a subtraction, a multiplication or an exponentiation after the **>** prompt:

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

When you use the compiled version (for Windows, macOS or Linux), type the expression directly when invoking the _peano_ executable:

    >peano 10 + 10
    20

Skipping the expression will result in an empty result:

    >peano
    
