; example-2,  a^nB^nc^n
; the finite set of states
#Q = {q0,q1,q2,q3,q4,qaccept}

; the finite set of input symbols
#S = {a,b,c}

; the complete set of tape symbols
#T = {a,b,c,A,B,C,_}

; the start state
#q0 = q0

; the blank symbol
#B = _

; the set of final states
#F = {qaccept}

; the transition functions
;  <present_state> <read_character> <write_character> <move_direction> <next_state>

q0 a A r q1
q0 B B r q4
q0 _ _ l qaccept

q1 a a r q1
q1 B B r q1
q1 b B r q2

q2 b b r q2
q2 C C r q2
q2 c C l q3

q3 a a l q3
q3 b b l q3
q3 B B l q3
q3 C C l q3
q3 A A r q0

q4 B B r q4
q4 C C r q4
q4 _ _ l qaccept

