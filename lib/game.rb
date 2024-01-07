# frozen_string_literal: true

require 'pry-byebug'

require_relative '../lib/board', '/..lib/piece', '/..lib/pieces_subclasses'

class Game
  attr_accessor :board, playing
  def initalize(board)
    @board = board
    @playing = true
  end

  def valid_move(piece,target_move)

    (target_x,target_y) = target_move
    #checks to build:
    # Obstruction
    # Check
    # Pawn Move
    # Castling / Au Passant
    case piece.class.name
    when Pawn
      #obstruction for forward move
      if piece.position[0] == target_x
        pawn_forward_move_valid?(piece, target_x, target_y)
      elsif # Need to check if the target x and y deltas vs current position == 1
        # Then implement the "pawn capture" check!
        # I think i can also use this for en passant as well, but would need to know about the last move of the piece next to it
        # Also need to check


    end

  end

  private

  def pawn_forward_move_valid?(piece, target_x, target_y)
    if piece.color == :white
      path_range = (piece.position[1] + 1)...target_y
    else
      (target_y + 1)...piece.position[1]
    end
    path_range.all? { |y| board[y][target_x].nil? }
  end

end
