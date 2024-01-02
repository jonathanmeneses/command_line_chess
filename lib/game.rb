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
    #checks to build:
    # Obstruction
    # Check
    # Pawn Move
    # Castling / Au Passant
    case piece.class.name
    when Pawn
      pass
    end

  end

end
