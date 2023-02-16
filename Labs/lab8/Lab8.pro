
%-----------------------------------------------------------------------------------------

%-- ASKHSH 1

is_sorted([]).
is_sorted([_]).
is_sorted([X, Y|Z]) :-
    X =< Y,
    is_sorted([Y|Z]).

insert([], L, L).
insert([H|T], L, [H|Q]) :-
    insert(T, L, Q).

get_element([H|_], 1, H) :- !.
get_element([_|T], N, H) :-
    N > 1,
    NEXT is N-1,
    get_element(T, NEXT, H).

pick_helper(_, [], S, S) :- !.
pick_helper(L, [H|T], S, RES) :-
    get_element(L, H, X),
    insert(S, [X], SNEXT),
    pick_helper(L, T, SNEXT, RES).

pick(L,I,S) :-
    is_sorted(I),
    !,
    pick_helper(L,I,[],S).

%-----------------------------------------------------------------------------------------

%-- ASKHSH 2

getFirst([], []).
getFirst([H|_], X) :- X = H.

getLast([X], X) :- !.
getLast([_|T], X) :-
    getLast(T, X).

extract(X, [X|T], T).  
extract(X, [F|T1], [F|T2]) :-
    extract(X, T1, T2).

all_permutations([], []).
all_permutations([H|T], RES) :-
    all_permutations(T, NEXT),
    extract(H, RES, NEXT).

take(_, [], []).
take(N, _, RES) :-
    N =< 0,
    !,
    N =:= 0,
    RES = [].
take(N, [H|TX], [H|TY]) :-
    NEXT is N-1,
    take(NEXT, TX, TY),
    !.

eql(X, Y) :- X == Y.

is_domino([H|T]) :-
    take(2, [H|T], PAIR),
    getFirst(PAIR, L1),
    getLast(PAIR, L2),
    getLast(L1, X),
    getFirst(L2, Y),
    eql(X, Y).

find_domino([_]).
find_domino([H|T]) :-
    is_domino([H|T]),
    find_domino(T).

domino([]) :- false, !.
domino([_]) :- true, !.
domino(L) :-
    % TODO Poly xronovoro.
    all_permutations(L, PERMS),
    find_domino(PERMS),
    !.

%-----------------------------------------------------------------------------------------
