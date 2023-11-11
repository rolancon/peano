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
  if li = none [left: "0" return left]
  it: ""

  switch li [
    #"0" [either index > 1 [change left index #"9" it: predecessors (index - 1) left #"1"] [left: "0" return left]]
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
    left: predecessor0 index left
    if left = "0" [return left]
 
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
  while [ll < lr] [
    append left #"0"
    ll: length? left
  ]

  forall right [successors (index? right) left right/1]

  left
]

subtraction: func [left right] [
  either left = "0" [return left] [if right = "0" [return right]]
  
  ll: length? left
  lr: length? right
  if lr > ll [return "0"]
  while [lr < ll] [
    right: rejoin ["0" right]
    lr: length? right
  ]

  forall right [
    it: predecessors (index? right) left right/1
    if it = "0" [return it]
  ]

  left
]

multiplication: func [left right] [
  if any [left = "0" right = "0"] [return "0"]
  either left = "1" [return right] [if right = "1" [return left]]

  adder: copy left
  plus: copy "0"
  offset: #"0"
  
  forall right [
    pred: predecessor right/1
   
    while [char? pred] [
      plus: addition plus (copy adder) plus (copy adder)
      pred: predecessor pred
    ]
  
    adder: rejoin [offset adder]
  ]

  plus
]

exponentiation: func [left right] [
  if any [left = "0" right = "0"] [return "0"]
  either left = "1" [return "1"] [if right = "1" [return left]]

  total: copy "0"
  sum: copy "1"
  times: copy left
  multiplier: copy "1"

  forall right [
    r: right/1
    if all [r <> none r <> #"0"] [

      multi: copy "1"
      p: predecessor r
      multi-copy: copy multiplier
    
      while [(exclude copy multi-copy "0") <> ""] [

        while [char? p] [
          multi: multiplication multi (copy times)
          p: predecessor p
        ]

        sum: multiplication sum (copy multi)

        multi-copy: subtraction multi-copy (copy "1")
      ]

      total: addition total (copy sum)
    ]

    append multiplier "0"
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
; clear leading zeroes
; negative numbers
; division, logarithms
; fractions, reals
; multiples, mixing
; grouping, nesting (parens)
; nth root

s: system/script/args
either s = "" [
  forever [
    s: ask "> "
    if s = "" [break]
    result: calc s
    print reverse result
  ]
] [
  result: calc s
  print reverse result
]
