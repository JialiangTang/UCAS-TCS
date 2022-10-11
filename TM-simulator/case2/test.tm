; Assignment 3 Problem 2 (b)
; This turning machine decides if the input string is ww, w is (a|b)*

; the finite set of states
#Q = {q0,q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11,accept,accept2,accept3,accept4,halt_accept,reject,rejectL,reject2,reject3,reject4,reject5,halt_reject}

; the finite set of input symbols
#S = {a,b}

; the complete set of tape symbols
#T = {a,b,c,d,x_,T,r,u,e,F,a,l,s}

; the start state
#q0 = q0

; the blank symbol
#B = _

; the set of final states
#F = {halt_accept}



; DESIGNING IDEA
; firstly, move around to find the middle of the input string. 
; then compare two substrings one by one

; In order to distinguish between visited position and unvisited, change visited 'a' to 'c', 'b' to 'd'
q0 a c r q1
q0 b d r q1

; q1: move to the rightmost, mark a character
q1 a a r q1
q1 b b r q1
q1 c c l q2
q1 d d l q2
q1 _ _ l q2
q1 * * * reject

; q2: find the rightmost unvisited character
q2 a c l q3
q2 b d l q3
q2 * * * reject

; q3: return to left
q3 a a l q3
q3 b b l q3
q3 c c r q0
q3 d d r q0
q3 * * * reject

; back to q0: reading a 'c' or 'd' in q0 means that head points to the middle of the string (also the beginning of the second w)
; Note: here use x to hold the position
q0 c x l q4     ; read c in the second w, enter first brunch
q0 d x l q5     ; read d in the second w, enter second brunch
q0 _ _ * accept ; empty string can be accepted
q0 * * * reject

; First Brunch q4: examine if the matched position of the first w is 'c'
q4 c c l q4
q4 d d l q4
q4 _ _ r q6      ; the visited character of the first w will directly br erased, so here we just walk to the leftmost of the whole string
q4 * * * reject

; First Brunch q6: only c matches in this brunch
q6 c _ r q8
q6 * * * reject

; Second Brunch q5: examine if the matched position of the first w is 'd'
q5 c c l q5
q5 d d l q5
q5 _ _ r q7      ; the visited character of the first w will directly br erased, so here we just walk to the leftmost of the whole string
q5 * * * reject

; Second Brunch q7: only d matches in this brunch
q7 d _ r q8
q7 * * * reject

; Now, two brunches meets at state q8. It means that one character is matched correctly. 

; q8: move to the next oisition in the second w
q8 c c r q8
q8 d d r q8
q8 x x r q9
q8 * * * reject

; q9: go over the 'x's left by q0->q4 or q0->q5, 
; finally moving to a blank means that the whole w has been matched, so we accept
; if find a 'c' or 'd', continue matching. 
q9 x x r q9
q9 _ _ l accept
q9 c x l q10     ; read c in the second w, enter first brunch
q9 d x l q11     ; read d in the second w, enter second brunch
q9 * * * reject

; q10: repeat what have been done in q4->q6->q8->q9->q10
q10 x x l q10
q10 c c l q10
q10 d d l q10
q10 _ _ r q6
q10 * * * reject

; q11: repeat what have been done in q5->q7->q8->q9->q11
q11 x x l q11
q11 c c l q11
q11 d d l q11
q11 _ _ r q7
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