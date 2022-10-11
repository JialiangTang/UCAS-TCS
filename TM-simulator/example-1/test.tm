; example 1.  0^n1^n

; the finite set of states
#Q = {q0, q1,q2,q3,q4,qaccept}

; the finite set of input symbols
#S = {a,b}

; the complete set of tape symbols
#T = {a,b,_,x}

; the start state
#q0 = q0

; the blank symbol
#B = _

; the set of final states
#F = {qaccept}

; the transition functions


; rule: <present_state> <read_character> <write_character> <move_direction> <next_state>

q0 x x r q0
q0 _ _ r qaccept
q0 a x r q1
q0 b x r q3

q1 x x r q1
q1 a a r q1
q1 b x l q2

q2 x x l q2
q2 a a l q2
q2 b b l q2
q2 _ _ r q0

q3 x x r q3
q3 b b r q3
q3 a x l q4

q4 x x l q4
q4 a a l q4
q4 b b l q4
q4 _ _ r q0