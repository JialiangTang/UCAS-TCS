;example-5,   m-n
; the finite set of states
#Q = {q0,q1,q2,q3,q4,q5,q6,q7,q8,qaccept}

; the finite set of input symbols
#S = {0,1}

; the complete set of tape symbols
#T = {0,1,_,A}

; the start state
#q0 = q0

; the blank symbol
#B = _

; the set of final states
#F = {qaccept}

; the transition functions
;  <present_state> <read_character> <write_character> <move_direction> <next_state>

q0 1 A r q1
q0 0 0 r q7

q1 0 0 r q2
q1 1 1 r q1

q2 0 0 r q2
q2 1 0 l q3
q2 _ _ l q4

q3 0 0 l q3
q3 1 0 r q2
q3 A A r q5

q4 0 _ l q4
q4 1 1 l q4
q4 A 1 l qaccept

q5 0 0 r q5
q5 1 1 r q5
q5 _ _ l q6

q6 0 _ l q6
q6 1 _ l q6
q6 A _ l qaccept

q7 1 1 r q7
q7 _ _ l q8

q8 0 _ l q7
q8 1 _ l qaccept
