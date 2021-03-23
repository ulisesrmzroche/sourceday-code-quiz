# sourceday-code-quiz

## Setup

`bundle install`

## Running the game

To play a game: `bundle exec rake play`
To play a single-hand game: `bundle exec rake 'play[single_hand]'`

Run tests with `bundle exec rake spec`
## SPEC

[x] - Create an application that mimics the game of black jack from the Ruby console based on the rules above.

[x] No uer input is required.

[x] -  Player should stop taking another card if total is 17 or higher.

[x] Game should print out card totals and who wins each round.

[x] Game should consist of a Card shoe with 6 total decks within. 

[x] Card Shoe should be shuffled when only 2 total decks remain.

[x] Decks will consist of 52 cards. Cards Numbers and Suits should be represented as follows.

Initial Rules of the Game: 

Blackjack, also known as twenty-one, is the most widely played casino banking game in the world. Blackjack is a comparing card game between a player and dealer, meaning that players compete against the dealer but not against any other players. It is played with one or more decks of 52 cards. The object of the game is to beat the dealer, which can be done in a number of ways:

Get 21 points on the player’s first two cards (called a blackjack), without a dealer blackjack;
Reach a final score higher than the dealer without exceeding 21; or
Let the dealer draw additional cards until his or her hand exceeds 21.

The player or players are dealt an initial two-card hand and add together the value of their cards. Face cards (kings, queens, and jacks) are counted as 10 points. A player and the dealer can count his or her own Ace as 1 point or 11 points. All other cards are counted as the numeric value shown on the card. After receiving their initial two cards, players have the option of getting a “hit”, taking an additional card. In a given round, the player or the dealer wins by having a score of 21 or by having the highest score that is less than 21. Scoring higher than 21 (called “busting” or “going bust”) results in a loss. A player may win by having any final score equal to or less than 21 if the dealer busts. If a player holds an ace valued as 11, the hand is called “soft”, meaning that the player cannot go bust by taking an additional card; 11 plus the value of any other card will always be less than or equal to 21. Otherwise, the hand is “hard”.

The dealer has to take hits until his or her cards total 17 or more points. (In some casinos the dealer also hits on a “soft” 17, e.g. an initial ace and six.) Players win if they do not bust and have a total that is higher than the dealer’s. The dealer loses if he or she busts or has a lesser hand than the player who has not busted. If the player and dealer have the same tot
