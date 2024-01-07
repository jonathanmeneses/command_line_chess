# frozen_string_literal: true
# rubocop:disable Metrics/MethodLength, Metrics/AbcSize

require 'pry-byebug'

require_relative '../lib/board', '/../lib/piece', '/../lib/pieces_subclasses'

class Game
  attr_accessor :board, :playing
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
      # Still need to build en passant
      if piece.position[0] == target_x
        pawn_forward_move_valid?(piece, target_x, target_y)
      elsif (target_x - piece.position[0]).abs == 1 && (target_y - piece.position[1]).abs == 1
        capture_move_valid?(piece, target_x, target_y)
        # I think i can also use this for en passant as well, but would need to know about the last move of the piece next to it
        # Also need to check
      else
        false
      end


    when Knight
      knight_move_valid?(piece, target_x, target_y)
    end
  end


  private

  def pawn_forward_move_valid?(piece, target_x, target_y)
    path_range = if piece.color == :white
                   (piece.position[1] + 1)...target_y
                 else
                   (target_y + 1)...piece.position[1]
                 end
    path_range.all? { |y| board[y][target_x].nil? }
  end

  def capture_move_valid(piece, target_x, target_y)
    if board[target_y][target_x]
      if piece.color == :white
        board[target_y][target_x].color == :black
      elsif piece.color == :black
        board[target_y][target_x].color == :white
      end
    else
      false
    end
  end

  def knight_move_valid?(piece, target_x, target_y)
    target_square = board[target_y][target_x]
    target_square.nil? || target_square.color != piece.color
  end

end
