; example-3，w-->ww 
; the finite set of states
#Q = {q0,q1,q2,q3,q4,q5,qaccept}

; the finite set of input symbols
#S = {a,b}

; the complete set of tape symbols
#T = {a,b,X,A,B,_}

; the start state
#q0 = q0

; the blank symbol
#B = _

; the set of final states
#F = {qaccept}

; the transition functions
;  <present_state> <read_character> <write_character> <move_direction> <next_state>

q0 a X r q1
q0 b X r q3
q0 A a r q5
q0 B b r q5
q0 _ _ l qaccept

q1 a a r q1
q1 b b r q1
q1 A A r q1
q1 B B r q1
q1 _ A l q2

q2 a a l q2
q2 b b l q2
q2 A A l q2
q2 B B l q2
q2 X a r q0

q3 a a r q3
q3 b b r q3
q3 A A r q3
q3 B B r q3
q3 _ B l q4

q4 a a l q4
q4 b b l q4
q4 A A l q4
q4 B B l q4
q4 X b r q0

q5 A a r q5
q5 B b r q5
q5 _ _ r qaccept
