quantity(X, 4) :- isTile(X).

% isTriplet(X) :- 

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

