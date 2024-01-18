# command_line_chess
A command line two-player chess game built as part of "The Odin Project" curriculum

# Instructions (per The Odin Project curriculum)

1. Build a command line Chess game where two players can play against each other.
2. The game should be properly constrained – it should prevent players from making illegal moves and declare check or check mate in the correct situations.
3. Make it so you can save the board at any time (remember how to serialize?)
4. Write tests for the important parts. You don’t need to TDD it (unless you want to), but be sure to use RSpec tests for anything that you find yourself typing into the command line repeatedly.
5. Do your best to keep your classes modular and clean and your methods doing only one thing each. This is the largest program that you’ve written, so you’ll definitely start to see the benefits of good organization (and testing) when you start running into bugs.
6. Unfamiliar with Chess? Check out some of the additional resources to help you get your bearings.
7. Have fun! Check out the unicode characters for a little spice for your gameboard.
8. (Optional extension) Build a very basic AI computer player (perhaps who does a random legal move)

## My strategies for development

1. Note that this requires notation style moves. moves should be entered with a 4 character string in the format of [move1][move2], eg. a2a4 would be "moving player piece from a2 to a4"
2. What is needed for future development:
    * Add instructions and better "incorrect move" text
    * Implement en passant logic
    * Implement pawn promotion logic
    * implement staelemate game state
    * visual updates (perhaps turn this into a web chess game)
    * save and load game states
