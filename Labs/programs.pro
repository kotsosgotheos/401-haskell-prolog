nat(0).
nat(s(X)) :- nat(X).

sum(X, 0, X) :- nat(X).
sum(X, s(Y), s(Z)) :- sum(X, Y, Z).


sum10(X, Y, RES) :- RES is X + Y.


fact(0, 1).
fact(N, F) :-
    K is N - 1,
    fact(K, G),
    F is N * G.


power(N, 0, 1).
power(N, K, RES) :-
    L is K // 2,
    power(N, L, R),
    M is K mod 2,
    power_(M, N, Z),
    RES is R * R * Z.
power_(0, N, 1).
power_(1, N, N).


sum1(0, 0).
sum1(N, RES) :-
    K is N - 1,
    sum1(K, R),
    power(N, N, P),
    RES is R + P.


gcdEuc(N, N, N).
gcdEuc(M, N, RES) :-
    M < N,
    K is N - M,
    gcdEuc(M, K, RES).
gcdEuc(M, N, RES) :-
    M > N,
    K is M - N,
    gcdEuc(N, K, RES).


gcdFast(0, M, M).
gcdFast(M, N, RES) :-
    M < N,
    K is N mod M,
    gcdFast(K, M, RES).
gcdFast(M, N, RES) :-
    M >= N,
    K is M mod N,
    gcdFast(K, N, RES).


sumabcd(A, A, C, C, RES) :-
    power(A, C, RES).
sumabcd(A, A, C, D, RES) :-
    C < D,
    N is (C + D) // 2,
    K is N + 1,
    sumabcd(A, A, C, N, RES1),
    sumabcd(A, A, K, D, RES2),
    RES is RES1 + RES2.
sumabcd(A, B, C, D, RES) :-
    A < B,
    M is (A + B) // 2,
    L is M + 1,
    sumabcd(A, M, C, D, RES1),
    sumabcd(L, B, C, D, RES2),
    RES is RES1 + RES2.


sqrtInt(N, RES) :-
    sqrtInt_(N, 0, N, RES).
sqrtInt_(N, A, A, A).
sqrtInt_(N, A, B, RES) :-
    A < B,
    C is (A + B + 1) // 2,
    K is C * C,
    newInterval(N, C, K, A, B, A_, B_),
    sqrtInt_(N, A_, B_, RES).
newInterval(N, C, K, A, B, A, D) :-
    K > N,
    D is C - 1.
newInterval(N, C, K, A, B, C, B) :-
    K =< N.


mymember(X, [X|T]).
mymember(X, [H|T]) :- mymember(X, T).


mydelete(X, [X|T], T).
mydelete(X, [H|T], [H|RES]) :- mydelete(X, T, RES).


lengthList([], 0).
lengthList([H|T], RES) :-
    lengthList(T, R),
    RES is R + 1.


elemList(1, [H|T], H).
elemList(N, [H|T], RES) :-
    M is N - 1,
    elemList(M, T, RES).


conc([], L, L).
conc([H|T], L, [H|RES]) :- conc(T, L, RES).
