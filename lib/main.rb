# frozen_string_literal: true

require 'pry-byebug'

require_relative '../lib/board'
require_relative '../lib/game'
require_relative '../lib/pieces_subclasses'

game = Game.new(Board.new)

# board.display_board

bishop = Bishop.new([4,4], :white)
pawn = Pawn.new([6,6], :white)

puts bishop.position

game.board.update_board_square(bishop.position[0], bishop.position[1], bishop)
game.board.update_board_square(pawn.position[0], pawn.position[1], pawn)

game.board.display_board

# bishop_white = Bishop.new([0, 2], :white)

# game = Game.new(board)

game.move_piece(bishop,[6,6])
game.board.display_board


#next up:
#
# Define what it means to be in check
# Create a simulation board to check if a move will put the moving team in check
# Restrict moves when in check
# Determine
