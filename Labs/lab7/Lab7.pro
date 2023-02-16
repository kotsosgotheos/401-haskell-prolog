
%-----------------------------------------------------------------------------------------

%-- ASKHSH 1

lengthList([], 0).
lengthList([_|T], N) :-
    lengthList(T, M),
    N is M + 1.

insert(N, [], [N]).
insert(N, [H|T], [N, H|T]) :-
    N @>= H.
insert(N, [H|T], [H|S]) :-
    N @< H,
    insert(N, T, S).

insSort([], []).
insSort([H|T], S) :-
    insSort(T, R),
    insert(H, R, S),
    !.

find_number_of_occurencies([], []) :- !.
find_number_of_occurencies([H|T], OCC) :-
    enumerate_elements(T, [1,H], OCC).

enumerate_elements([], [N,ELEM], [[N,ELEM]]).
enumerate_elements([H|T], [N,H], F) :-
    !,
    NPLUSPLUS is N + 1,
    enumerate_elements(T, [NPLUSPLUS,H], F).
enumerate_elements([H|T], [N,ELEM], [[N,ELEM]|F]) :-
    enumerate_elements(T, [1,H], F).

getFirst([], []).
getFirst([H|_], X) :- X = H.

getLast([], []).
getLast([_|T], X) :-
    getFirst(T, X).

most_frequent(L, N, C) :-
    insSort(L, SORTED_L),
    find_number_of_occurencies(SORTED_L, OCC),
    insSort(OCC, SORTED_OCC),
    getFirst(SORTED_OCC, MAX_ELEMENT),
    getFirst(MAX_ELEMENT, N),
    getLast(MAX_ELEMENT, C).

majority([], no) :- !.
majority(L,C) :-
    most_frequent(L, N, C),
    lengthList(L, LEN),
    N > LEN / 2,
    !.


%-----------------------------------------------------------------------------------------

%-- ASKHSH 2

generate_powers_of_2(0, L, [1|L]) :- !.
generate_powers_of_2(N, R, L) :-
    N > 0,
    POWER_NUMBER is 2 ^ N,
    NEXT is N - 1,
    generate_powers_of_2(NEXT, [POWER_NUMBER|R], L).

find_next_bigger_power(0, _, 1).
find_next_bigger_power(LEN, [H|_], TIMES) :-
    LEN is H,
    TIMES is 0.
find_next_bigger_power(LEN, [H|_], TIMES) :-
    LEN < H,
    TIMES is H - LEN.
find_next_bigger_power(LEN, [H|T], TIMES) :-
    LEN > H,
    find_next_bigger_power(LEN, T, TIMES).

insert_times([], _, [0]).
insert_times(L, 0, L).
insert_times(L, TIMES, E) :-
    insert(0, L, NEXT_L),
    NEXT_TIMES is TIMES - 1,
    insert_times(NEXT_L, NEXT_TIMES, E),
    !.

expand(L,E) :-
    lengthList(L, LEN),
    generate_powers_of_2(LEN, [], POW),
    find_next_bigger_power(LEN, POW, TIMES),
    insert_times(L, TIMES, E),
    !.



%-----------------------------------------------------------------------------------------

%majority([],X).
%majority(['Messi'],X).
%majority(['Ronaldo', 'Messi'],X).
%majority(['Mbappe', 'Messi', 'Mbappe'],X).
%majority(['Ronaldo', 'Ronaldo', 'Messi', 'Messi', 'Ronaldo', 'Ronaldo', 'Ronaldo', 'Salah', 'Mbappe'],X).
%majority(['Ronaldo', 'Messi', 'Messi', 'Dybala', 'Messi', 'Messi', 'Salah', 'Mbappe'],X).
%majority(['Messi', 'Ronaldo', 'Messi', 'Salah', 'Salah', 'Salah', 'Salah'],X).
%majority(['Dybala', 'Dybala', 'Dybala', 'Dybala', 'Messi'],X).
%majority(['Messi', 'Messi', 'Messi', 'Ronaldo', 'Haaland', 'Ronaldo', 'Ronaldo', 'Mbappe', 'Messi', 'Messi', 'Messi'],X).
%majority(['Mbappe', 'Messi', 'Mbappe', 'Ronaldo', 'Mbappe', 'Ronaldo', 'Mbappe', 'Messi', 'Mbappe'],X).
%majority(['Mbappe', 'Messi', 'Salah', 'Ronaldo', 'Dybala', 'Ronaldo', 'Mbappe', 'Messi', 'Mbappe', 'Salah'],X).
%majority(['Ronaldo', 'Haaland', 'Ronaldo','Ronaldo', 'Messi', 'Ronaldo', 'Haaland', 'Messi', 'Ronaldo','Ronaldo', 'Messi', 'Messi', 'Messi', 'Messi', 'Messi', 'Mbappe', 'Messi', 'Mbappe', 'Messi', 'Messi', 'Messi', 'Messi', 'Mbappe', 'Messi', 'Dybala', 'Messi', 'Dybala', 'Messi', 'Messi','Dybala'],X).
