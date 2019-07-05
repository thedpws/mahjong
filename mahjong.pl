isEquivalent(Hand1, Hand2, Equivalency) :- quicksort(Hand1, Hand1Sorted), quicksort(Hand2, Hand2Sorted), isEquivalentHelp(Hand1Sorted, Hand2Sorted, Equivalency).
isEquivalentHelp([H|T1], [H|T2], Equivalency) :- isEquivalentHelp(T1, T2, Equivalency).
isEquivalentHelp([], [], true).


% Quicksort
pivot(_, [], [], []).
pivot(Pivot, [Head|Tail], [Head|LessThan], GreaterThanOrEqualTo) :- not(isLessThan(Pivot, Head)), pivot(Pivot, Tail, LessThan, GreaterThanOrEqualTo). 
pivot(Pivot, [Head|Tail], LessThan, [Head|GreaterThanOrEqualTo]) :- isLessThan(Pivot, Head), pivot(Pivot, Tail, LessThan, GreaterThanOrEqualTo).

quicksort([], []).
quicksort([Head|Tail], Sorted) :- pivot(Head, Tail, List1, List2), quicksort(List1, SortedList1), quicksort(List2, SortedList2), append(SortedList1, [Head|SortedList2], Sorted).

quantity(X, 4) :- isTile(X).

isRun(X) :- X=[Tile1,Tile2,Tile3], value(Tile1, V0), value(Tile2, V0+1), value(Tile3, V0+2).
isTriplet(X) :- length(X, 3), listMatches(X).
isQuadruplet(X) :- length(X, 4), listMatches(X).

listMatches(X) :- length(X, 1).
listMatches(X) :- X = [H1,H2 | T ], matches(H1, H2), listMatches([H2|T]).

matches(X, X).

matchesSuit(X,Y) :- suit(X, Suit), suit(Y, Suit).

isSimple(X) :- isSuit(X), not(isTerminal(X)).

isTerminal(X) :- value(X, 1).
isTerminal(X) :- value(X, 9).

isTile(X) :- isHonor(X).
isTile(X) :- isSuit(X, _).

isHonor(X) :- dragon(X, _).
isHonor(X) :- wind(X, _).

isSuit(X) :- suit(X, _).

value(bamboo_1, 1).
value(bamboo_2, 2).
value(bamboo_3, 3).
value(bamboo_4, 4).
value(bamboo_5, 5).
value(bamboo_6, 6).
value(bamboo_7, 7).
value(bamboo_8, 8).
value(bamboo_9, 9).

value(circle_1, 1).
value(circle_2, 2).
value(circle_3, 3).
value(circle_4, 4).
value(circle_5, 5).
value(circle_6, 6).
value(circle_7, 7).
value(circle_8, 8).
value(circle_9, 9).

value(character_1, 1).
value(character_2, 2).
value(character_3, 3).
value(character_4, 4).
value(character_5, 5).
value(character_6, 6).
value(character_7, 7).
value(character_8, 8).
value(character_9, 9).

suit(bamboo_1, bamboo).
suit(bamboo_2, bamboo).
suit(bamboo_3, bamboo).
suit(bamboo_4, bamboo).
suit(bamboo_5, bamboo).
suit(bamboo_6, bamboo).
suit(bamboo_7, bamboo).
suit(bamboo_8, bamboo).
suit(bamboo_9, bamboo).

suit(character_1, character).
suit(character_2, character).
suit(character_3, character).
suit(character_4, character).
suit(character_5, character).
suit(character_6, character).
suit(character_7, character).
suit(character_8, character).
suit(character_9, character).

suit(circle_1, circle).
suit(circle_2, circle).
suit(circle_3, circle).
suit(circle_4, circle).
suit(circle_5, circle).
suit(circle_6, circle).
suit(circle_7, circle).
suit(circle_8, circle).
suit(circle_9, circle).


dragon(white_dragon, white).
dragon(red_dragon, red).
dragon(green_dragon, green).

wind(east_wind, east).
wind(south_wind, south).
wind(west_wind, west).
wind(north_wind, north).

%  ____                                 _                     
% / ___|___  _ __ ___  _ __   __ _ _ __(_)___  ___  _ __  ___ 
%| |   / _ \| '_ ` _ \| '_ \ / _` | '__| / __|/ _ \| '_ \/ __|
%| |__| (_) | | | | | | |_) | (_| | |  | \__ \ (_) | | | \__ \
% \____\___/|_| |_| |_| .__/ \__,_|_|  |_|___/\___/|_| |_|___/
%                     |_|                                     

isLessThan(L, G) :- isSuit(L), isHonor(G).                  % Suits < Honors
isLessThan(L, G) :- suit(L, bamboo), suit(G, circle).       % Bamboo < Circle < Character
isLessThan(L, G) :- suit(L, bamboo), suit(G, character). 
isLessThan(L, G) :- suit(L, circle), suit(G, character).
isLessThan(L, G) :- suit(L, Suit), suit(G, Suit), value(L, V0), value(G, V1), V1 > V0.    % 1 < 2 < ... < 9
isLessThan(L, G) :- dragon(L, _), wind(G, _).               % Dragon < Wind
isLessThan(L, G) :- dragon(L, white), dragon(G, red).         % White < Red < Green
isLessThan(L, G) :- dragon(L, white), dragon(G, green).         % White < Red < Green
isLessThan(L, G) :- dragon(L, red), dragon(G, green).
isLessThan(L, G) :- wind(L, east), wind(G, south).              % East < South < West < North
isLessThan(L, G) :- wind(L, east), wind(G, west).
isLessThan(L, G) :- wind(L, east), wind(G, north).
isLessThan(L, G) :- wind(L, south), wind(G, west).
isLessThan(L, G) :- wind(L, south), wind(G, north).
isLessThan(L, G) :- wind(L, west), wind(G, north).
