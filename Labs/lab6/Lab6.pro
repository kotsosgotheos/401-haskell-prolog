
%-----------------------------------------------------------------------------------------

%-- ASKHSH 1

dif(X,Y) :- X \= Y.

factorization(_, 2, 3) :- !.
factorization(N, F, NF) :-
    F * F < N,
    !,
    NF is F + 2.
factorization(N, _, N).

constructPrimes(N, PRIMES) :-
    N > 0,
    constructPrimes(N, PRIMES, 2).

constructPrimes(1, [], _) :- !.
constructPrimes(N, [H|PRIMES], H) :-
    R is N // H,
    N =:= R * H,
    !,
    constructPrimes(R, PRIMES, H).
constructPrimes(N, PRIMES, H) :-
    factorization(N, H, NF),
    constructPrimes(N, PRIMES, NF).

lengthList([], 0).
lengthList([_|T], N) :-
    lengthList(T, M),
    N is M + 1.

getFirst([], []).
getFirst([H|_], X) :- X = H.

getLast([], []).
getLast([H], X) :-
    X is H,
    !.
getLast([_|T], X) :-
    getLast(T, X).

bipolarDivisor(1,1) :- !.
bipolarDivisor(N,D) :-
    constructPrimes(N, PRIMES),
    lengthList(PRIMES, LEN),
    LEN is 1,
    D is N,
    !.
bipolarDivisor(N,D) :-
    constructPrimes(N, PRIMES),
    getFirst(PRIMES, MIN),
    getLast(PRIMES, MAX),
    D is MIN * MAX.

%-----------------------------------------------------------------------------------------

%-- ASKHSH 2

nat(0).
nat(s(X)) :-
    nat(X).

difference(X, 0, X) :-
    nat(X),
    !.
difference(s(X), s(Y), Z) :-
    difference(X, Y, Z).

divide(_, 0, "undefined") :- !.
divide(0, _, 0) :- !.

divide(RES, 0, RES) :-
    nat(RES),
    !.
divide(X,Y,s(D)) :-
    difference(X, Y, RES),
    divide(RES, Y, D).

%-----------------------------------------------------------------------------------------
