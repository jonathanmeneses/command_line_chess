# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/game'
require_relative '../lib/pieces_subclasses'

game = Game.new(Board.new)

# board.display_board

bishop = Bishop.new([4,4], :white)

puts bishop.position

game.board.update_board_square(bishop.position[0], bishop.position[1], bishop)


game.board.display_board

# bishop_white = Bishop.new([0, 2], :white)

# game = Game.new(board)

# game.move_piece(bishop_white,[2,4])

# game.board.display_board
