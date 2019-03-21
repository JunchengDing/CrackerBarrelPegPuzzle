:- use_module(library(lambda)).

% main
go :-
	numlist(0,14, Lst),
	maplist(puzzle(),Lst).

% puzzle for different initlization
puzzle(Init) :-
	format('=== ~w ===~n~n', Init),
	puzzle(Moves,Init),
	display(Moves,[Init]),
	format('~n~n').

% initialize puzzle
puzzle(Moves,Occupied) :-
	numlist(0,14, Lst),
	select(Occupied,Lst,Empty),
	play([Occupied], Empty, [], Moves).
 
 % play function
play(_, [_], Lst, Moves) :-
	reverse(Lst, Moves).
 
play(Free, Occupied, Lst, Moves) :-
	select(S, Occupied, Oc1),
	select(O, Oc1, Oc2),
	select(E, Free, F1),
	move(S, O, E),
	play([S, O | F1], [E | Oc2], [move(S,O,E) | Lst], Moves).

% possible move
move(S,1,E) :-
	member([S,E], [[0,3], [3,0]]).
move(S,2,E) :-
	member([S,E], [[0,5], [5,0]]).
move(S,3,E):-
	member([S,E], [[1,6], [6,1]]).
move(S,4,E):-
	member([S,E], [[1,8], [8,1]]).
move(S,4,E):-
	member([S,E], [[2,7], [7,2]]).
move(S,5,E):-
	member([S,E], [[2,9], [9,2]]).
move(S,4,E):-
	member([S,E], [[3,5], [5,3]]).
move(S,6,E):-
	member([S,E], [[3,10], [10,3]]).
move(S,7,E):-
	member([S,E], [[3,12], [12,3]]).
move(S,7,E):-
	member([S,E], [[4,11], [11,4]]).
move(S,8,E):-
	member([S,E], [[4,13], [13,4]]).
move(S,8,E):-
	member([S,E], [[5,12], [12,5]]).
move(S,9,E):-
	member([S,E], [[5,14], [14,5]]).
move(S,7,E):-
	member([S,E], [[6,8], [8,6]]).
move(S,8,E):-
	member([S,E], [[9,7], [7,9]]).
move(S,11,E):-
	member([S,E], [[10,12], [12,10]]).
move(S,12,E):-
	member([S,E], [[11,13], [13,11]]).
move(S,13,E):-
	member([S,E], [[14,12], [12,14]]).
 
% display function
display([], Free) :-
	numlist(0,14, Lst),
	maplist(\X^I^(member(X, Free) -> I = 0; I = 1),
		Lst,
		[I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15]),
	format('    ~w        ~n', [I1]),
	format('   ~w ~w      ~n', [I2,I3]),
	format('  ~w ~w ~w    ~n', [I4,I5,I6]),
	format(' ~w ~w ~w ~w  ~n', [I7,I8,I9,I10]),
	format('~w ~w ~w ~w ~w~n', [I11,I12,I13,I14,I15]).
 
 
display([move(Start, Middle, End) | Tail], Free) :-
	numlist(0,14, Lst),
	maplist(\X^I^(member(X, Free) -> I = 0; I = 1),
		Lst,
		[I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15]),
	format('    ~w        ~n', [I1]),
	format('   ~w ~w      ~n', [I2,I3]),
	format('  ~w ~w ~w    ~n', [I4,I5,I6]),
	format(' ~w ~w ~w ~w  ~n', [I7,I8,I9,I10]),
	format('~w ~w ~w ~w ~w~n~n', [I11,I12,I13,I14,I15]),
	select(End, Free, F1),
	display(Tail,  [Start, Middle | F1]).
