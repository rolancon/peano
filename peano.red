Red []

next: func [left index number] [
  ;prin "left: " print left
  ;prin "index: " print index
  ;prin "number: " print number
  ;prin "type number: " print type? number
  left/(:index): number
  ;prin "new left/:index: " print left/:index
]

successor: func [index left] [
  li: left/:index
  if li = none [append left #"0" li: left/:index]
  ;prin "li: " print li
  ;prin "type li: " print type? li
  switch li [
    #"0" [next left index #"1"]
    #"1" [next left index #"2"]
    #"2" [next left index #"3"]
    #"3" [next left index #"4"]
    #"4" [next left index #"5"]
    #"5" [next left index #"6"]
    #"6" [next left index #"7"]
    #"7" [next left index #"8"]
    #"8" [next left index #"9"]
    #"9" [next left index #"0" predecessors (index + 1) left "1"]
  ]
]

predecessors: func [index left right] [
  ;prin "index: " print index
  ;prin "right: " print right
  ;prin "type? right: " print type? right
  if right <> #"0" [
    successor index left
    switch right [
	 ;#"0" is never reached
      #"1" []
      #"2" [predecessors index left #"1"]
      #"3" [predecessors index left #"2"]
      #"4" [predecessors index left #"3"]
      #"5" [predecessors index left #"4"]
      #"6" [predecessors index left #"5"]
      #"7" [predecessors index left #"6"]
      #"8" [predecessors index left #"7"]
      #"9" [predecessors index left #"8"]
    ]
  ]
]

addition: func [l r left right] [
  either l = "0" [print r exit] [if r = "0" [print l exit]]
  forall right [predecessors (index? right) left right/1]
  prin "result: " print reverse left
  print ""
]

subtraction: func [l r left right] [
  either l = "0" [print rejoin ["-" r] exit] [if r = "0" [print l exit]]
]

multiplication: func [l r left right] [
  if any [l = "0" r = "0"] [print "0" exit]
]

calc: func [sum] [
  terms: split sum " "
  ;prin "terms: " print terms
  l: terms/1
  op: terms/2
  r: terms/3
  left: reverse l
  ;prin "left: " print left
  right: reverse r
  ;prin "right: " print right

  switch op [
    "+" [addition l r left right]
    "-" [subtraction l r left right]
    "*" [multiplication l r left right]
  ]
]

; ToDo
; negative numbers, minus
; multiplication, power of
; division, root of
; fracions, reals
; multiples, mixing
; grouping, parens

calc "0 + 0"
calc "0 + 1"
calc "1 + 0"

calc "0 - 0"
calc "0 - 1"
calc "1 - 0"

calc "0 * 0"
calc "0 * 1"
calc "1 * 0"

forever [
  s: ask "> "
  calc s
]
