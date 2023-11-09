Red []

change: func [left index number] [
  left/(:index): number
]

successor: func [index left] [
  li: left/:index
  if li = none [append left #"0" li: left/:index]

  switch li [
    #"0" [change left index #"1"]
    #"1" [change left index #"2"]
    #"2" [change left index #"3"]
    #"3" [change left index #"4"]
    #"4" [change left index #"5"]
    #"5" [change left index #"6"]
    #"6" [change left index #"7"]
    #"7" [change left index #"8"]
    #"8" [change left index #"9"]
    #"9" [change left index #"0" successors (index + 1) left "1"]
  ]
]

successors: func [index left right] [
  if right <> #"0" [
    successor index left

    switch right [
      ;#"0"
      #"1" []
      #"2" [successors index left #"1"]
      #"3" [successors index left #"2"]
      #"4" [successors index left #"3"]
      #"5" [successors index left #"4"]
      #"6" [successors index left #"5"]
      #"7" [successors index left #"6"]
      #"8" [successors index left #"7"]
      #"9" [successors index left #"8"]
    ]
  ]
]

predecessor: func [right] [
  switch right [
    #"0" [none]
    #"1" [#"0"]
    #"2" [#"1"]
    #"3" [#"2"]
    #"4" [#"3"]
    #"5" [#"4"]
    #"6" [#"5"]
    #"7" [#"6"]
    #"8" [#"7"]
    #"9" [#"8"]
  ]
]

predecessor0: func [index left] [
  li: left/:index
  ;if li = none [append left #"0" li: left/:index] ;sign: "-"
  if li = none [left: "0" return left]
  prin "li: " print li
  it: ""

  switch li [
    #"0" [prin "index: " print index
          either index > 1 [change left index #"9" it: predecessors (index - 1) left #"1"] [left: "0" return left]]
    #"1" [change left index #"0"]
    #"2" [change left index #"1"]
    #"3" [change left index #"2"]
    #"4" [change left index #"3"]
    #"5" [change left index #"4"]
    #"6" [change left index #"5"]
    #"7" [change left index #"6"]
    #"8" [change left index #"7"]
    #"9" [change left index #"8"]
  ]

  if it = "0" [return it] 
  left
]

predecessors: func [index left right] [
  if all [left <> "0" right <> #"0"] [
    prin "index: " print index
    prin "left before: " print left
    prin "right: " print right
    left: predecessor0 index left
    prin "left after: " print left
    if left = "0" [print "OK" return left]
 
    switch right [
      ;#"0"
      #"1" [predecessors index left #"0"]
      #"2" [predecessors index left #"1"]
      #"3" [predecessors index left #"2"]
      #"4" [predecessors index left #"3"]
      #"5" [predecessors index left #"4"]
      #"6" [predecessors index left #"5"]
      #"7" [predecessors index left #"6"]
      #"8" [predecessors index left #"7"]
      #"9" [predecessors index left #"8"]
    ]

    left
  ]
]

addition: func [left right] [
  either left = "0" [return right] [if right = "0" [return left]]

  ll: length? left
  lr: length? right
  prin "ll: " print ll
  prin "lr: " print lr
  while [ll < lr] [
    append left #"0"
    ll: length? left
    prin "ll: " print ll
  ]
  prin "left: " print left

  forall right [successors (index? right) left right/1]

  left
]

subtraction: func [left right] [
  either left = "0" [return left] [if right = "0" [return right]]
  ;either l = "0" [return rejoin [r "-"]] [if r = "0" [return l]]
  ;if any [left = "0" right = "0"] [return left]

  prin "left: " print left
  prin "right: " print right
  
  ll: length? left
  lr: length? right
  prin "ll: " print ll
  prin "lr: " print lr
  if lr > ll [return "0"]
  while [lr < ll] [
    right: rejoin ["0" right]
    lr: length? right
    prin "lr: " print lr
  ]
  prin "right: " print right

  ;sign: ""
  forall right [
    it: predecessors (index? right) left right/1
    print "it: " it
    if it = "0" [return it]
  ]

  ;append left sign
  left
]

multiplication: func [left right] [
  if any [left = "0" right = "0"] [return "0"]
  either left = "1" [return right] [if right = "1" [return left]]

  prin "left: " print left
  prin "right: " print right

  adder: copy left
  plus: copy "0"
  offset: #"0"
  
  forall right [
    pred: predecessor right/1
   
    while [char? pred] [
      prin "plus before: " print plus
      prin "adder before: " print adder
      plus: addition plus (copy adder) plus (copy adder)
      prin "plus after: " print plus
      prin "adder after: " print adder
      prin "pred: " print pred
      pred: predecessor pred
    ]
  
    adder: rejoin [offset adder]
  ]

  plus
]

exponentiation: func [left right] [
  if any [left = "0" right = "0"] [return "0"]
  either left = "1" [return "1"] [if right = "1" [return left]]

  prin "left: " print left
  prin "right: " print right

  total: copy "0"
  sum: copy "1"
  times: copy left
  off: copy ""
  multiplier: copy "1"

  forall right [
    multi: copy "1"
    p: predecessor right/1
    prin "multiplier: " print multiplier
    prin "off: " print off
    times: rejoin [off times]
    prin "times: " print times

    while [multiplier > "0"] [

    while [char? p] [
      prin "multi before: " print multi
      prin "times before: " print times
      multi: multiplication (copy multi) (copy times) (copy multi) (copy times)
      prin "multi after: " print multi
      prin "times after: " print times
      prin "p: " print p
      p: predecessor p
    ]

    prin "sum before: " print sum
    sum: multiplication (copy sum) (copy multi) (copy sum) (copy multi)
    prin "sum after: " print sum
    prin "total before: " print total
    total: addition (copy total) (copy sum) (copy total) (copy sum)
    prin "total after: " print total
    append multiplier "0"
    append off "0"

    multiplier: "0"
    ;multiplier: subtraction (copy multiplier) (copy "1") (copy multiplier) (copy "1")
    ]
  ]

  total
]

calc: func [expr] [
  terms: split expr " "
  l: terms/1
  op: terms/2
  r: terms/3
  left: reverse copy l
  right: reverse copy r

  switch op [
    "+" [addition left right]
    "-" [reverse (subtraction l r)]
    "*" [multiplication left right]
    "**" [exponentiation left right]
  ]
]

; ToDo:
; negative numbers (minus)
; division, logarithms
; fractions, reals
; multiples, mixing
; grouping, nesting (parens)
; nth root

;calc "0 + 0"
;calc "0 + 1"
;calc "1 + 0"
;calc "1 + 1"

;calc "0 - 0"
;calc "0 - 1"
;calc "1 - 0"
;calc "1 - 1"

;calc "0 * 0"
;calc "0 * 1"
;calc "1 * 0"
;calc "1 * 1"

;calc "0 ** 0"
;calc "0 ** 1"
;calc "1 ** 0"
;calc "1 ** 1"

forever [
  s: ask "> "
  if s = "" [break]
  result: calc s
  prin "result: " print result
  ;to-integer
  ;clear zeroes
  print reverse result
]
