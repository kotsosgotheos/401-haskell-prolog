
%-----------------------------------------------------------------------------------------

%-- ASKHSH 1

myabs(A, B) :-
    A < 0,
    B is - A.
myabs(A, B) :-
    A >= 0,
    B is A.

q1(C1,C2) :-
    event(_, C1, D),
    event(_, C2, D).

q2(X,Y,C) :-
    at(X, AX, _, C),
    at(Y, _, BY, C),
    dif(X, Y),
    BY > AX.

q3(S) :-
    country(C1, S),
    country(C2, S),
    country(C3, S),
    event(E1, C1, D1),
    event(E2, C2, _),
    event(E3, C3, D3),
    dif(E1, E2), dif(E2, E3), dif(E1, E3),
    !,
    DAYS is D3 - D1,
    myabs(DAYS, ABSDAYS),
    ABSDAYS =< 7.

q4(X) :-
    at(X, A1, B1, C1),
    at(X, A2, B2, C2),
    event(_, C1, D1),
    event(_, C2, D2),
    country(C1, S1),
    country(C2, S2),
    dif(S1, S2),
    D1 =< B1, D1 >= A1,
    D2 =< B2, D2 >= A2,
    !.

%-----------------------------------------------------------------------------------------

%-- ASKHSH 2

prec(A, A, N, TOT) :-
    TOT =< N,
    !.
prec(A, B, N, TOT) :-
    plane(A, MED, PRICE),
    TOTPRICE is TOT + PRICE,
    TOTPRICE =< N,
    prec(MED, B, N, TOTPRICE),
    !.
prec(A, B, N, TOT) :-
    boat(A, MED, PRICE),
    TOTPRICE is TOT + PRICE,
    TOTPRICE =< N,
    prec(MED, B, N, TOTPRICE),
    !.
prec(A, B, N, TOT) :-
    train(A, MED, PRICE),
    TOTPRICE is TOT + PRICE,
    TOTPRICE =< N,
    prec(MED, B, N, TOTPRICE),
    !.

p(A,B,N) :- prec(A, B, N, 0).




other_transport(A, A, N, TOT) :-
    TOT =< N,
    !.
other_transport(A, B, N, TOT) :-
    boat(A, MED, PRICE),
    TOTPRICE is TOT + PRICE,
    TOTPRICE =< N,
    other_transport(MED, B, N, TOTPRICE),
    !.
other_transport(A, B, N, TOT) :-
    train(A, MED, PRICE),
    TOTPRICE is TOT + PRICE,
    TOTPRICE =< N,
    other_transport(MED, B, N, TOTPRICE),
    !.

q(A,B) :-
    plane(A, B, PRICE),
    PRICEOTHER = PRICE * 80/100,
    other_transport(A, B, PRICEOTHER, 0),
    !.

% r(A,B,N) :-




%-----------------------------------------------------------------------------------------

%-----------------------------------------------------------------------------------------
%-----------------------------------------------------------------------------------------
%-----------------------------------------------------------------------------------------

%-- MHN TROPOPOIHSETE TO PARAKATW TMHMA KWDIKA 



dif(X,Y) :- X \= Y.

at(tiger,1,14,'Berlin').
at(tiger,15,15,'Hamburg').
at(tiger,16,37,'Athens').
at(tiger,38,50,'Rome').
at(wolf,1,4,'Rome').
at(wolf,5,5,'London').
at(wolf,6,7,'Rome').
at(wolf,8,8,'Rotterdam').
at(wolf,9,24,'Rome').
at(wolf,25,25,'Athens').
at(wolf,26,30,'Rome').
at(wolf,31,40,'Paris').
at(wolf,41,41,'Rome').
at(wolf,42,42,'Barcelona').
at(wolf,43,50,'Rome').
at(hawk,1,10,'Berlin').
at(hawk,11,20,'Stuttgart').
at(hawk,21,35,'Hamburg').
at(hawk,36,50,'Frankfurt').
at(shark,1,16,'Amsterdam').
at(shark,17,20,'London').
at(shark,21,29,'Paris').
at(shark,30,45,'Rome').
at(shark,43,48,'Brussels').
at(shark,49,50,'London').
at(spider,1,12,'Brussels').
at(spider,13,17,'Berlin').
at(spider,18,50,'Brussels').
at(snake,1,10,'Rome').
at(snake,11,20,'Milan').
at(snake,21,50,'Berlin').

event(e001,'Berlin',2).
event(e002,'Madrid',3).
event(e003,'London',5).
event(e004,'Rome',7).
event(e005,'Bristol',10).
event(e006,'Stuttgart',13).
event(e007,'Milan',17).
event(e008,'Amsterdam',17).
event(e009,'Rotterdam',18).
event(e010,'Hamburg',24).
event(e011,'Amsterdam',24).
event(e012,'Athens',25).
event(e013,'Groningen',25).
event(e014,'Paris',31).
event(e015,'Strasbourg',31).
event(e016,'Paris',37).
event(e017,'Brussels',40).
event(e018,'Brussels',41).
event(e019,'Barcelona',42).
event(e020,'Frankfurt',43).
event(e021,'Brussels',43).
event(e022,'London',47).

country('Amsterdam','Netherlands').
country('Athens','Greece').
country('Barcelona','Spain').
country('Berlin','Germany').
country('Bristol','United Kingdom').
country('Brussels','Belgium').
country('Frankfurt','Germany').
country('Groningen','Netherlands').
country('Hamburg','Germany').
country('London','United Kingdom').
country('Madrid','Spain').
country('Milan','Italy').
country('Paris','France').
country('Rome','Italy').
country('Rotterdam','Netherlands').
country('Strasbourg','France').
country('Stuttgart','Germany').



train(X,Y,N) :- train___(X,Y,N). 
train(X,Y,N) :- train___(Y,X,N). 

train___(astralCity,frozenTown,5).
train___(astralCity,greenTown,24).
train___(astralCity,rainyPort,15).
train___(brightCity,kindTown,21).
train___(crazyCity,vainPort,5).
train___(crazyCity,zeroTown,7).
train___(dreamCity,oldTown,3).
train___(dreamCity,newTown,4).
train___(dreamCity,timePort,6).
train___(eternalCity,mysteryTown,4).
train___(frozenTown,greenTown,27).
train___(greenTown,honeyTown,11).
train___(greenTown,icyTown,12).
train___(honeyTown,joyTown,10).
train___(honeyTown,piratesPort,9).
train___(icyTown,joyTown,15).
train___(joyTown,kindTown,18).
train___(joyTown,sunnyPort,20).
train___(kindTown,quietPort,25).
train___(luckyTown,mysteryTown,5).
train___(luckyTown,utopiaPort,7).
train___(oldTown,timePort,5).
train___(whitePort,xenonTown,7).
train___(whitePort,yellowTown,8).


boat(X,Y,N) :- boat___(X,Y,N). 
boat(X,Y,N) :- boat___(Y,X,N). 

boat___(piratesPort,whitePort,45).
boat___(quietPort,whitePort,42).
boat___(quietPort,utopiaPort,75).
boat___(rainyPort,quietPort,58).
boat___(rainyPort,vainPort,38).
boat___(rainyPort,whitePort,48).
boat___(sunnyPort,timePort,30).
boat___(sunnyPort,utopiaPort,32).
boat___(timePort,vainPort,87).
boat___(vainPort,whitePort,53).


plane(X,Y,N) :- plane___(X,Y,N). 
plane(X,Y,N) :- plane___(Y,X,N). 

plane___(astralCity,brightCity,120).
plane___(astralCity,crazyCity,80).
plane___(astralCity,dreamCity,90).
plane___(astralCity,eternalCity,150).
plane___(brightCity,crazyCity,140).
plane___(brightCity,dreamCity,110).
plane___(brightCity,eternalCity,70).
plane___(dreamCity,eternalCity,107).

