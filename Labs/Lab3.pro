%%%%
%%  Name: Athanasios Papapostolou
%%  AM: 4147
%%%%

%-----------------------------------------------------------------------------------------
%-- ASKHSH 1

% Custom `abs` predicate carrying the state
abs_difference(A, B, RES) :-
    A > B,
    RES is A - B.
abs_difference(A, B, RES) :-
    A < B,
    RES is B - A.

twice(C, N) :-
    % Grab Y1 and Y2 values
    hosted(_, Y1, C),
    hosted(_, Y2, C),
    abs_difference(Y1, Y2, RES),

    % Make sure the the given state persists
    RES >= N,
    !. % Stop and succeed

in2Cities(D) :-
    % Grab cities
    country(C1, D),
    country(C2, D),
    dif(C1, C2),    
    !. % Check for difference then stop and succeed

in3Continents(I) :-
    K is I + 1,
    L is I + 2,

    % Grab cities
    hosted(I, _, C1),
    hosted(K, _, C2),
    hosted(L, _, C3),

    % Grab countries
    country(C1, D1),
    country(C2, D2),
    country(C3, D3),

    % Grab continents
    continent(D1, RES1),
    continent(D2, RES2),
    continent(D3, RES3),

    % Check for difference
    dif(RES1, RES2),
    dif(RES2, RES3),
    dif(RES1, RES3),
    !. % Stop and succeed

%-----------------------------------------------------------------------------------------
%-- ASKHSH 2

% Check if `X` exits in a list counter
mymember(X, [X|_]).
mymember(X, [_|T]) :- mymember(X, T).

% Delete from list
mydelete(X, [X|T], T).
mydelete(X, [H|T], [H|RES]) :-
    mydelete(X, T, RES).

myinsert(X, [], [X]).
% Negation of delete
myinsert(X, L, L1) :-
    mydelete(X, L1, L).

% Check if the current station color equals the color of the next
checkForStationSwitch(LINE, CURR, ENTRANCE, CURRENTCOLOR) :-
    % Grab the line of our current station
    nextStation(LINE, CURR, _),
    LINE == CURRENTCOLOR,

    % If the comparison passes we are still on the same line
    ENTRANCE is 0,
    !.

checkForStationSwitch(LINE, CURR, ENTRANCE, CURRENTCOLOR) :-
    nextStation(LINE, CURR, _),
    dif(LINE, CURRENTCOLOR),

    % We have hopped lines
    entranceFare(LINE, ENTRANCE),
    !.

move(A, B, C) :-
    nextStation(LINE, A, _),
    
    % Grab the first line to charge for the initial entrance fare
    entranceFare(LINE, INITIALPAY),
    move_(A, B, C, INITIALPAY, LINE, []),
    !.

% Base case where the station equals our destination
move_(B, B, C, TOTAL, _, _) :-
    !,
    TOTAL =< C.

% Recursive case
move_(A, B, C, TOTAL, CURRENTCOLOR, SAVEDNODES) :-
    % Make sure we dont go circles around 2 stations
    % TODO, ADD A LIST COUNTER TO SAVE TRAVELLED NODES FOR BACKTRACKING
    nextStation(_, PREV, A),
    nextStation(LINE, A, NEXT),

    % Check if we passes the same node before
    \+mymember(A, SAVEDNODES),
    myinsert(A, SAVEDNODES, SAVEDNODES_),
    
    dif(PREV, NEXT),

    %display(A),display('|'),

    % Grab the current entrance fee
    checkForStationSwitch(LINE, A, ENTRANCE, CURRENTCOLOR),
    travelFare(LINE, TRAVEL),

    % Update the total fare counter
    TOTAL_ is TOTAL + ENTRANCE + TRAVEL,
    !,

    % Recurse through to the next node
    move_(NEXT, B, C, TOTAL_, CURRENTCOLOR, SAVEDNODES_).

%-----------------------------------------------------------------------------------------
%-- ASKHSH 3

% Implements first function case for helper
f_(N, _, 1, PREV, Y) :- N =< 0, Y is PREV, !.
f_(_, M, 1, PREV, Y) :- M =< 0, Y is PREV, !.
f_(N, M, 1, PREV, Y) :- M > N, Y is PREV, !.

% Implements second function case for helper
f_(_, M, 1, PREV, Y) :- M is 1, Y is PREV + 1, !.
f_(N, M, 1, PREV, Y) :- M is N, Y is PREV + 1, !.

% Implements recursive case
f_(N, M, I, PREV, Y) :-
    I_ is I - 1,

    % We reduce to either 1 or 0 and add the values together to find `Y`
    f_(N, M, I_, PREV, Y),
    !.

f(N, _, 0) :- N =< 0, !.
f(_, M, 0) :- M =< 0, !.
f(N, M, 0) :- M > N, !.

f(_, M, 1) :- M is 1, !.
f(N, M, 1) :- M is N, !.
f(N, M, Y) :-
    % Fix the values for the next iteration
    M_ is M + 1,
    N_ is N - M,

    % Call the helper to reduce the function sum
    f_(N_, M, M_, 0, Y1),

    % Recurse through `f` to find the rest of the values
    f(N_, M, Y2),

    % Get the result
    Y is Y1 + Y2.

%-----------------------------------------------------------------------------------------
%-- ASKHSH 4

% Base case for `divisible` where the value is true
divisible(X, Y) :-
    N is Y * Y,
    N =< X,
    X mod Y =:= 0.
% Recursive case to look for the next number in the line
divisible(X, Y) :-
    Y < X,
    Y1 is Y + 1,
    divisible(X, Y1).

% Check if a number is prime
isprime(X) :-
    Y is 2,
    X > 1,

    % `\+` for negation
    \+divisible(X, Y).

% Get the next value in the pipeline
next(2, 3) :- !.
next(A, A1) :- A1 is A + 2.

% Get a list of prime numbers
p_list(A, B, []) :-
    % Stop when the list is empty
    A > B, !.
% Recusive case
p_list(A, B, [A|L]) :-
    isprime(A),
    % Get the first prime check passed and stop backtracking
    !,
    next(A, A1),
    p_list(A1, B, L).
% First call
p_list(A, B, L) :-
    next(A, A1),
    p_list(A1, B, L).

% Construct a prime number list
prime_list(A, B, L) :-
    A =< 2,
    !,
    p_list(2, B, L).
prime_list(A, B, L) :-
    A1 is (A // 2) * 2 + 1,
    p_list(A1, B, L).

p(N) :-
    % Check for a positive value
    N > 0,
    K is N - 1,

    % Craft the prime list
    prime_list(1, K, PRIMES),
    
    % Answer the given predicate
    is_not_divided_by_prime_square(K, PRIMES).

% Checks if the square of a prime number divides our list current
is_not_divided_by_prime_square(N, [H|_]) :-
    P is H * H,
    N =< P,
    % Base case where the the predicate is false
    !. % Stop and fail
is_not_divided_by_prime_square(N, [H|T]) :-
    P is H * H,
    K is N mod P,
    dif(K, 0),

    % If the dif check passes continue recursively
    is_not_divided_by_prime_square(N, T).

%-----------------------------------------------------------------------------------------
%-----------------------------------------------------------------------------------------
%-----------------------------------------------------------------------------------------

%-- MHN TROPOPOIHSETE TO PARAKATW TMHMA KWDIKA 

dif(X,Y) :- X \= Y.

hosted(1,1896,'Athens').
hosted(2,1900,'Paris').
hosted(3,1904,'St. Louis').
hosted(4,1908,'London').
hosted(5,1912,'Stockholm').
hosted(7,1920,'Antwerp').
hosted(8,1924,'Paris').
hosted(9,1928,'Amsterdam').
hosted(10,1932,'Los Angeles').
hosted(11,1936,'Berlin').
hosted(14,1948,'London').
hosted(15,1952,'Helsinki').
hosted(16,1956,'Melbourne').
hosted(17,1960,'Rome').
hosted(18,1964,'Tokyo').
hosted(19,1968,'Mexico City').
hosted(20,1972,'Munich').
hosted(21,1976,'Montreal').
hosted(22,1980,'Moscow').
hosted(23,1984,'Los Angeles').
hosted(24,1988,'Seoul').
hosted(25,1992,'Barcelona').
hosted(26,1996,'Atlanta').
hosted(27,2000,'Sydney').
hosted(28,2004,'Athens').
hosted(29,2008,'Beijing').
hosted(30,2012,'London').
hosted(31,2016,'Rio de Janeiro').


country('Melbourne','Australia').
country('Sydney','Australia').
country('Antwerp','Belgium').
country('Rio de Janeiro','Brazil').
country('Montreal','Canada').
country('Beijing','China').
country('Helsinki','Finland').
country('Paris','France').
country('Berlin','Germany').
country('Athens','Greece').
country('Rome','Italy').
country('Tokyo','Japan').
country('Mexico City','Mexico').
country('Amsterdam','Netherlands').
country('Seoul','South Korea').
country('Moscow','Soviet Union').
country('Barcelona','Spain').
country('Stockholm','Sweden').
country('London','United Kingdom').
country('St. Louis','United States of America').
country('Los Angeles','United States of America').
country('Atlanta','United States of America').
country('Munich','West Germany').

continent('Australia','Oceania').
continent('Belgium','Europe').
continent('Brazil','America').
continent('Canada','America').
continent('China','Asia').
continent('Finland','Europe').
continent('France','Europe').
continent('Germany','Europe').
continent('Greece','Europe').
continent('Italy','Europe').
continent('Japan','Asia').
continent('Mexico','America').
continent('Netherlands','Europe').
continent('South Korea','Asia').
continent('Soviet Union','Europe').
continent('Spain','Europe').
continent('Sweden','Europe').
continent('United Kingdom','Europe').
continent('United States of America','America').
continent('West Germany','Europe').



nextStation(green,X,Y) :- green(X,Y).
nextStation(red,X,Y) :- red(X,Y).
nextStation(blue,X,Y) :- blue(X,Y).
nextStation(yellow,X,Y) :- yellow(X,Y).

entranceFare(blue,10).
entranceFare(green,10).
entranceFare(red,60).
entranceFare(yellow,20).

travelFare(blue,15).
travelFare(green,15).
travelFare(red,5).
travelFare(yellow,8).


green(a1,b1).
green(b1,b2).
green(b2,c3).
green(c3,c4).
green(c4,b4).
green(b4,b5).
green(b5,b6).
green(b6,b7).
green(b7,a8).
green(a8,b8).
green(b8,c8).
green(b1,a1).
green(b2,b1).
green(c3,b2).
green(c4,c3).
green(b4,c4).
green(b5,b4).
green(b6,b5).
green(b7,b6).
green(a8,b7).
green(b8,a8).
green(c8,b8).
yellow(b1,c1).
yellow(c1,d1).
yellow(d1,e1).
yellow(e1,d2).
yellow(d2,d3).
yellow(d3,c4).
yellow(c4,d4).
yellow(d4,e4).
yellow(e4,f5).
yellow(f5,e5).
yellow(e5,d5).
yellow(d5,d6).
yellow(d6,c7).
yellow(c7,c8).
yellow(c8,d8).
yellow(d8,e8).
yellow(e8,f8).
yellow(c1,b1).
yellow(d1,c1).
yellow(e1,d1).
yellow(d2,e1).
yellow(d3,d2).
yellow(c4,d3).
yellow(d4,c4).
yellow(e4,d4).
yellow(f5,e4).
yellow(e5,f5).
yellow(d5,e5).
yellow(d6,d5).
yellow(c7,d6).
yellow(c8,c7).
yellow(d8,c8).
yellow(e8,d8).
yellow(f8,e8).
blue(d2,f1).
blue(f1,g1).
blue(g1,h1).
blue(h1,g2).
blue(g2,g3).
blue(g3,g4).
blue(g4,f5).
blue(f5,f6).
blue(f6,f7).
blue(f7,f8).
blue(f8,g7).
blue(g7,h8).
blue(f1,d2).
blue(g1,f1).
blue(h1,g1).
blue(g2,h1).
blue(g3,g2).
blue(g4,g3).
blue(f5,g4).
blue(f6,f5).
blue(f7,f6).
blue(f8,f7).
blue(g7,f8).
blue(h8,g7).
red(a2,b3).
red(b3,c3).
red(c3,d3).
red(d3,e3).
red(e3,e2).
red(e2,f2).
red(f2,f3).
red(f3,g3).
red(g3,h2).
red(h2,h3).
red(h3,h4).
red(h4,h5).
red(h5,h6).
red(h6,h7).
red(h7,g6).
red(g6,f6).
red(f6,e7).
red(e7,d7).
red(d7,d6).
red(d6,c6).
red(c6,b6).
red(b6,a7).
red(a7,a6).
red(a6,a5).
red(a5,a4).
red(a4,a3).
red(a3,a2).
red(b3,a2).
red(c3,b3).
red(d3,c3).
red(e3,d3).
red(e2,e3).
red(f2,e2).
red(f3,f2).
red(g3,f3).
red(h2,g3).
red(h3,h2).
red(h4,h3).
red(h5,h4).
red(h6,h5).
red(h7,h6).
red(g6,h7).
red(f6,g6).
red(e7,f6).
red(d7,e7).
red(d6,d7).
red(c6,d6).
red(b6,c6).
red(a7,b6).
red(a6,a7).
red(a5,a6).
red(a4,a5).
red(a3,a4).
red(a2,a3).
