; Assignment 3 Problem 2 (a)
; This turning machine decides if the input string is 1^mx1^n=1^mn
; for example, 111x11=111111 will be accepted and 1x1=11 will be rejected

; the finite set of states
#Q = {start,q0,q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11,accept,accept2,accept3,accept4,halt_accept,reject,rejectL,reject2,reject3,reject4,reject5,halt_reject}

; the finite set of input symbols
#S = {1,x,=}

; the complete set of tape symbols
#T = {1,x,=,_,T,r,u,e,F,a,l,s}

; the start state
#q0 = start

; the blank symbol
#B = _

; the set of final states
#F = {halt_accept}



; DESIGNING IDEA:
; use 1^m as a counter, each time erase a '1' from 1^m and erase n '1's from 1^mn. 
; after 1^m being comsumed, examine if the 1^mn has been consumed as well. 

; start: the input can only be started with '1', the TM does not accept "x1=1"
start 1 1 * q0
start * * * reject

; q0: use the 1^m as a counter, delete one '1' each time
q0 1 _ r q1

; q1: after deleting a '1' of 1^m, just go over 1^m, do not make changes
q1 1 1 r q1
q1 x x r q2
q1 * * * reject

; q2: after reading the 'x', then read 1^n
; it is necessary to use q2 to guarantee that the input has only one 'x'
; use 1^n to delete n '1's in 1^mn
q2 0 0 r q2
q2 1 0 r q3
q2 * * * reject

; q3: go over the rest '1's in 1^n
q3 1 1 r q3
q3 = = r q4
q3 * * * reject

; q4: go over 1^mn, find the tail of the input
q4 1 1 r q4
q4 _ _ l q5
q4 * * * reject

q5 1 _ l q6
q5 * * * reject

; q6: go back to 1^n
q6 1 1 l q6
q6 = = l q6
q6 0 0 r q7

; q7: if the 1^n have not been consumed, repeat what have bee done in q3~q7
; else, go back to 1^m
q7 1 0 r q3
q7 = = l q8
q7 * * * reject

; q8: recover the '0's to '1's
q8 0 1 l q8
q8 x x l q9
q8 * * * reject

; q9: find the beginning of the input, then repeat what have been done in q0~q9
q9 1 1 l q9
q9 _ _ r q0
q9 * * * reject

; back to q0: now all '1's in 1^m have been consumed, and the input can only been accepted if 1^mn has been consumed as well
q0 x x r q10
q0 * * * reject

; q10: go over 1^n
q10 1 1 r q10
q10 = = r q11
q10 * * * reject

; q11: if nothing is on the right of '=', enter accept
q11 _ _ l accept
q11 * * * reject

accept * _ l accept
accept _ T r accept2
accept2 _ r r accept3
accept3 _ u r accept4
accept4 * e * halt_accept

; the head moves to the rightmost of the characters and then moves left to clear the tape
reject * * r reject
reject _ _ l rejectL
rejectL * _ l rejectL
rejectL _ F r reject2

reject2 * a r reject3
reject3 * l r reject4
reject4 * s r reject5
reject5 * e * halt_reject