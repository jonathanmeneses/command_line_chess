# frozen_string_literal: true

require 'pry-byebug'

require_relative '../lib/board'
require_relative '../lib/game'
require_relative '../lib/pieces_subclasses'
require_relative '../lib/ChessGame'

game = ChessGame.new

game.play_game

# board = Board.new

# binding.pry

puts "ok!"


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
