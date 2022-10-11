; example 6.

; the finite set of states
#Q = {q0, q1,q2,q3,qaccept}

; the finite set of input symbols
#S = {0,1}

; the complete set of tape symbols
#T = {0,1,_,}

; the start state
#q0 = q0

; the blank symbol
#B = _

; the set of final states
#F = {qaccept}

; the transition functions
;  <present_state> <read_character> <write_character> <move_direction> <next_state>

q0 0 0 r q0
q0 1 1 r q1

q1 0 0 r q1
q1 1 1 r q2

q2 0 0 r q2
q2 1 1 r q3
q2 _ _ r qaccept

q3 0 0 l q2
q3 1 1 l q2