% __  __       _      _                           _ 
%|  \/  | __ _| |__  (_) ___  _ __   __ _   _ __ | |
%| |\/| |/ _` | '_ \ | |/ _ \| '_ \ / _` | | '_ \| |
%| |  | | (_| | | | || | (_) | | | | (_| |_| |_) | |
%|_|  |_|\__,_|_| |_|/ |\___/|_| |_|\__, (_) .__/|_|
%                  |__/             |___/  |_|      

%###################################################
%#                                                 #
%#    https://github.com/thedpws/mahjong.git       #
%#                                                 #
%###################################################

countSetsHand(Hand, NSets) :- 
  include(  suit(bamboo),     Hand, Bamboos     ),
  include(  suit(circle),     Hand, Circles     ),
  include(  suit(character),  Hand, Characters  ),
  include(  isHonor,          Hand, Honors      ),
  countSets(Bamboos,    NBambooSets), 
  countSets(Circles,    NCircleSets),
  countSets(Characters, NCharacterSets),
  countSets(Honors, NHonorSets),
  (NSets is (NBambooSets+NCircleSets+NCharacterSets+NHonorSets)).

% all are same type bamboo, east, white, etc.

countSets([], 0).
countSets(Tiles, NSets) :-
  % Consider chi
  considerRun(Tiles, NSetsConsiderRun), 
  % Consider pon
  considerTriplet(Tiles, NSetsConsiderTriplet),
  % Consider kong
  considerQuadruplet(Tiles, NSetsConsiderQuadruplet),
  % Consider ignoring
  considerIgnore(Tiles, NSetsConsiderIgnore),
  % Take the max
  Considerations = [NSetsConsiderRun, NSetsConsiderTriplet, NSetsConsiderQuadruplet, NSetsConsiderIgnore],
  max_list(Considerations, NSets).
countSets(_, 0).




considerIgnore([], 0).
considerIgnore(Tiles, NRuns) :-
  Tiles = [_|Tail],
  countSets(Tail, NRuns).

considerRun(Tiles, NRuns) :-
  Tiles = [T1 | Tail],
  isRun([T1, T2, T3]),
  member(T2, Tail), member(T3, Tail),
  permutation(Tiles, [T1, T2, T3 | Leftover]),
  countSets(Leftover, NRecurse),
  NRuns is (1+NRecurse).
considerRun(Tiles, 0) :-
  not(
      (
       Tiles=[T1|_],
       isRun([T1, T2, T3]),
       member(T2, Tiles), member(T3, tiles),
       permutation(Tiles, [T1, T2, T3 | _])
      )
   ).


considerTriplet(Tiles, NTriplets) :-
  Tiles = [T1 | Tail],
  isTriplet([T1, T2, T3]),
  member(T2, Tail), member(T3, Tail),
  permutation(Tiles, [T1, T2, T3 | Leftover]),
  countSets(Leftover, NRecurse),
  NTriplets is (1+NRecurse).
considerTriplet(Tiles, 0) :- 
  not(
    (
     Tiles=[T1|_],
     isTriplet([T1, T2, T3]),
     member(T2, Tiles), member(T3, Tiles),
     permutation(Tiles, [T1, T2, T3 | _])
    )
   ).
considerQuadruplet(Tiles, NQuadruplets) :-
  Tiles = [T1 | Tail],
  isQuadruplet([T1, T2, T3]),
  member(T2, Tail), member(T3, Tail),
  permutation(Tiles, [T1, T2, T3 | Leftover]),
  countSets(Leftover, NRecurse),
  NQuadruplets is (1+NRecurse).
considerQuadruplet(Tiles, 0) :- 
  not(
    (
     Tiles=[T1|_],
     isQuadruplet([T1, T2, T3]),
     member(T2, Tiles), member(T3, Tiles),
     permutation(Tiles, [T1, T2, T3 | _])
    )
   ).


quantity(X, 4) :- isTile(X).

% _   _                 _     
%| | | | __ _ _ __   __| |___ 
%| |_| |/ _` | '_ \ / _` / __|
%|  _  | (_| | | | | (_| \__ \
%|_| |_|\__,_|_| |_|\__,_|___/

isRun(X) :- 
  X=[Tile1,Tile2,Tile3], 
  suit(Suit, Tile1), suit(Suit, Tile2), suit(Suit, Tile3), 
  value(V1, Tile1), value(V2, Tile2), value(V3, Tile3), V2 is V1+1, V3 is V2+1.
isPair([T, T]).
isTriplet([T, T, T]).
isQuadruplet([T, T, T, T]).

% _____ _ _           
%|_   _(_) | ___  ___ 
%  | | | | |/ _ \/ __|
%  | | | | |  __/\__ \
%  |_| |_|_|\___||___/
                     
matches(X, X).

matchesSuit(X,Y) :- suit(Suit, X), suit(Suit, Y).

isSimple(X) :- isSuit(X), not(isTerminal(X)).

isTerminal(X) :- value(1, X).
isTerminal(X) :- value(9, X).

isTile(X) :- isHonor(X).
isTile(X) :- isSuit(X, _).

isHonor(X) :- dragon(_, X).
isHonor(X) :- wind(_, X).

isSuit(X) :- suit(_, X).

value(1, bamboo_1).
value(2, bamboo_2).
value(3, bamboo_3).
value(4, bamboo_4).
value(5, bamboo_5).
value(6, bamboo_6).
value(7, bamboo_7).
value(8, bamboo_8).
value(9, bamboo_9).

value(1, circle_1).
value(2, circle_2).
value(3, circle_3).
value(4, circle_4).
value(5, circle_5).
value(6, circle_6).
value(7, circle_7).
value(8, circle_8).
value(9, circle_9).

value(1, character_1).
value(2, character_2).
value(3, character_3).
value(4, character_4).
value(5, character_5).
value(6, character_6).
value(7, character_7).
value(8, character_8).
value(9, character_9).

suit(bamboo, bamboo_1).
suit(bamboo, bamboo_2).
suit(bamboo, bamboo_3).
suit(bamboo, bamboo_4).
suit(bamboo, bamboo_5).
suit(bamboo, bamboo_6).
suit(bamboo, bamboo_7).
suit(bamboo, bamboo_8).
suit(bamboo, bamboo_9).

suit(character, character_1).
suit(character, character_2).
suit(character, character_3).
suit(character, character_4).
suit(character, character_5).
suit(character, character_6).
suit(character, character_7).
suit(character, character_8).
suit(character, character_9).

suit(circle, circle_1).
suit(circle, circle_2).
suit(circle, circle_3).
suit(circle, circle_4).
suit(circle, circle_5).
suit(circle, circle_6).
suit(circle, circle_7).
suit(circle, circle_8).
suit(circle, circle_9).


dragon(white, white_dragon).
dragon(red, red_dragon).
dragon(green, green_dragon).

wind(east, east_wind).
wind(south, south_wind).
wind(west, west_wind).
wind(north, north_wind).

% ____             _   _             
%/ ___|  ___  _ __| |_(_)_ __   __ _ 
%\___ \ / _ \| '__| __| | '_ \ / _` |
% ___) | (_) | |  | |_| | | | | (_| |
%|____/ \___/|_|   \__|_|_| |_|\__, |
%                              |___/ 
pivot(_, [], [], []).
pivot(Pivot, [Head|Tail], [Head|LessThan], GreaterThanOrEqualTo) :- not(isLessThan(Pivot, Head)), pivot(Pivot, Tail, LessThan, GreaterThanOrEqualTo). 
pivot(Pivot, [Head|Tail], LessThan, [Head|GreaterThanOrEqualTo]) :- isLessThan(Pivot, Head), pivot(Pivot, Tail, LessThan, GreaterThanOrEqualTo).

quicksort([], []).
quicksort([Head|Tail], Sorted) :- pivot(Head, Tail, List1, List2), quicksort(List1, SortedList1), quicksort(List2, SortedList2), append(SortedList1, [Head|SortedList2], Sorted).

isLessThan(L, G) :- isSuit(L), isHonor(G).                  % Suits < Honors
isLessThan(L, G) :- suit(bamboo, L), suit(circle, G).       % Bamboo < Circle < Character
isLessThan(L, G) :- suit(bamboo, L), suit(character, G). 
isLessThan(L, G) :- suit(circle, L), suit(character, G).
isLessThan(L, G) :- suit(Suit, L), suit(Suit, G), value(V1, L), value(V2, G), V2 > V1.    % 1 < 2 < ... < 9
isLessThan(L, G) :- dragon(_, L), wind(_, G).               % Dragon < Wind
isLessThan(L, G) :- dragon(white, L), dragon(red, G).         % White < Red < Green
isLessThan(L, G) :- dragon(white, L), dragon(green, G).         % White < Red < Green
isLessThan(L, G) :- dragon(red, L), dragon(green, G).
isLessThan(L, G) :- wind(east, L), wind(south, G).              % East < South < West < North
isLessThan(L, G) :- wind(east, L), wind(west, G).
isLessThan(L, G) :- wind(east, L), wind(north, G).
isLessThan(L, G) :- wind(south, L), wind(west, G).
isLessThan(L, G) :- wind(south, L), wind(north, G).
isLessThan(L, G) :- wind(west, L), wind(north, G).
