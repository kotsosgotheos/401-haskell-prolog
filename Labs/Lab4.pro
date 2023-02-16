%%%%
%%  Name: Athanasios Papapostolou
%%  AM: 4147
%%%%

%-----------------------------------------------------------------------------------------
%-- ASKHSH 1

% Elements are different
dif(X, Y) :- X \= Y.

% Elements are the same
eql(X, Y) :- X == Y.

% True if `X` is a member of the list
mymember(X, [X|_]).
mymember(X, [_|T]) :- mymember(X, T).

% Insert an element to the list
myinsert(N, [], [N]).
myinsert(N, [H|T], [N, H|T]) :-
    N @=< H.
myinsert(N, [H|T], [H|S]) :-
    N @> H,
    myinsert(N, T, S).

% Perform an insertion sort using `myinsert`
myinsertsort([], []).
myinsertsort([H|T], S) :-
    myinsertsort(T, R),
    myinsert(H, R, S).

% Call the helper to access input and output
...(N, M, K, L) :- helper(N, M, K, [], L).

% Once N zeros out, find the output
helper(0, _, _, IN, OUT) :- OUT = IN, !.
helper(N, M, K, IN, OUT) :-
    N_ is N - 1, % Counter for recursion
    
    % Calculate the value and insert to the list
    VALUE is M + K * N_,
    myinsert(VALUE, IN, LIN),
    !, % Only insert at the beginning
    helper(N_, M, K, LIN, OUT).

%-----------------------------------------------------------------------------------------
%-- ASKHSH 2

% Base case where either list empties
% Sort the output and get output
common_([], _, IN, OUT, _) :- myinsertsort(IN, L), OUT = L, !.
common_(_, [], IN, OUT, _) :- myinsertsort(IN, L), OUT = L, !.

common_([XH|XT], [YH|YT], IN, OUT, INDEX) :-
    % If the corresponding elements differ, continue
    dif(XH, YH),
    INDEX_ is INDEX + 1,
    common_(XT, YT, IN, OUT, INDEX_).
common_([XH|XT], [YH|YT], IN, OUT, INDEX) :-
    % If the corresponding elements are equal, then insert to the counter
    eql(XH, YH),
    myinsert(INDEX, IN, LIN),
    INDEX_ is INDEX + 1,
    common_(XT, YT, LIN, OUT, INDEX_).

% Call the base case with an empty counter list and index
common(X, Y, L) :- common_(X, Y, [], L, 1), !.

%-----------------------------------------------------------------------------------------
%-- ASKHSH 3

% Base case where the input list is empty
freq([], []) :- !.
freq(L, F) :-
    % Make sure the list is sorted before finding frequencies
    myinsertsort(L, L_),
    !,
    freq_(L_, F).

% Tabulate each elements head recursively
freq_([H|T], F) :-
    tab(T, 1*H, F).

% Last case where we emptied the list, where the value tabulated to `N*C`
tab([], N*C, [N*C]).
tab([H|T], N*H, F) :-
    !, % Make sure we dont backtrack since the order of elements doesnt matter
    N_ is N + 1,
    tab(T, N_*H, F). % Continue storing the last value
tab([H|T], N*C, [N*C|F]) :-
    tab(T, 1*H, F).

%-----------------------------------------------------------------------------------------
%-- ASKHSH 4

% Split the 2 element list returning first and second elements
% where FST is always lower than SND
access([], _, _).
access([H, T], HEAD, TAIL) :-
    H >= T,
    TAIL = H,
    HEAD = T,
    !.
access([H, T], HEAD, TAIL) :-
    H < T,
    HEAD = H,
    TAIL = T,
    !.

% Filter the created pairs where SND > 2 * FST
filterpairs([], IN, OUT) :- OUT = IN, !.
filterpairs([H|REST], IN, OUT) :-
    access(H, FST, SND),
    SND =< 2 * FST, % If this predicate is true we simply continue iterating
    filterpairs(REST, IN, OUT).
filterpairs([H|REST], IN, OUT) :-
    access(H, FST, SND),
    SND > 2 * FST,
    IN_ is IN + 1, % We increase the counter if the given predicate is correct
    filterpairs(REST, IN_, OUT).

% Get a pair if a member of the list
pair([H|T], [H, E]) :- mymember(E, T).
pair([_|T], P) :- pair(T, P).

% Use findall to get a list of pairs
findpairs(L, PAIRS) :- findall(P, pair(L, P), PAIRS).

% Count pairs by finding the lists and counting the number accordingly
count(L, C) :-
    findpairs(L, PAIRS),
    !,% Make sure we donc backtrack
    filterpairs(PAIRS, 0, COUNTER),
    C = COUNTER,
    !.
