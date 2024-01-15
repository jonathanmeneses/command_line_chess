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

1. Create the board class
2. Create a top level "Pieces" Class
3. Create subclasses for each piece type (inherits from the top level pieces)
4. Create Game class

### Special Rules to keep in mind
1. Castling
2. Double Pawn Move
3. Pawn Promotion
4. Castling


### Things to define
1. What is a legal move?
2. When is something in check
3. When is something in checkmate
    a. Checkmate is when there are no valid moves remaining for a team that is in check

### Creating the Pieces Class
1. Add position
2. Add color

### Creating the SubPieces Class

1. Add piece type
2. Add potential moves

## Outstanding items
1. Stalemate creation
2. en passant
3. pawn promotion
4. castling
5. need to check if piece capture works
6. Need to update icons on board
7. need to update board display
