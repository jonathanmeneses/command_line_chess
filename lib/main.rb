# frozen_string_literal: true

require 'pry-byebug'

require_relative '../lib/board'
require_relative '../lib/game'
require_relative '../lib/pieces_subclasses'

game = Game.new(Board.new)

# board.display_board

bishop = Bishop.new([4,4], :white)
b_king = King.new([1,1], :black)
pawn = Pawn.new([6,6], :white)

game.board.update_board_square(bishop.position[0], bishop.position[1], bishop)
game.board.update_board_square(pawn.position[0], pawn.position[1], pawn)
game.board.update_board_square(b_king.position[0], b_king.position[1], b_king)

p game.king_in_check?(:black, b_king, game.board)

game.board.display_board

# bishop_white = Bishop.new([0, 2], :white)

# game = Game.new(board)

p game.move_piece(bishop,[3,5])
p game.color_in_check?(:black, game.board)
# p game.valid_move?(bishop,[1,1])
# game.board.display_board


#next up:
#
# Define what it means to be in check
# Create a simulation board to check;
# 1.  if a move will put the moving team in check
# 2.  if a move will remove the moving team from check
# Restrict moves when in check
# Determine checkmate
#
# Should I refactor and add valid_moves to return all valid moves for a piece?
# if so, i could then have valid_move? just run an valid_moves.include?(move)
