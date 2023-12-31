# frozen_string_literal: true
# rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/ClassLength

require 'pry-byebug'

require_relative '../lib/board'
require_relative '../lib/piece'
require_relative '../lib/pieces_subclasses'

class Game
  attr_accessor :board, :playing

  def initialize(board)
    @board = board
    @playing = true
    @white_check = false
    @black_check = false
  end

  def move_piece(piece, target_move)
    (target_x, target_y) = target_move
    if valid_move?(piece, target_move)
      board.update_board_square(piece.position[0], piece.position[1],nil)
      board.update_board_square(target_x,target_y,piece)
      piece.position = [target_x, target_y]
    else
      puts "invalid move"
    end
  end

  def valid_move?(piece, target_move)
    (target_x, target_y) = target_move
    #checks to build:
    # Obstruction
    # Check
    # Pawn Move
    # Castling / Au Passant
    case piece.class.name
    when 'Pawn'
      pawn_move_valid?(piece,target_x, target_y)
    when 'Knight'
      knight_move_valid?(piece, target_x, target_y)
    when 'Bishop'
      bishop_move_valid?(piece, target_x, target_y)
    when 'Rook'
      rook_move_valid?(piece, target_x, target_y)
    when 'Queen'
      queen_move_valid?(piece, target_x, target_y)
    when 'King'
      king_move_valid?(piece, target_x, target_y)
    end
  end

  def update_check_status
    pass
  end


  private

  def pawn_forward_move_valid?(piece, target_x, target_y)
    path_range = if piece.color == :white
                   (piece.position[1] + 1)...target_y
                 else
                   (target_y + 1)...piece.position[1]
                 end
    path_range.all? { |y| board.grid[y][target_x].nil? }
  end

  def capture_move_valid?(piece, target_x, target_y)
    if board.grid[target_y][target_x]
      if piece.color == :white
        board.grid[target_y][target_x].color == :black
      elsif piece.color == :black
        board.grid[target_y][target_x].color == :white
      end
    else
      false
    end
  end

  def knight_move_valid?(piece, target_x, target_y)
    target_square = board.grid[target_y][target_x]
    target_square.nil? || target_square.color != piece.color
  end

  def bishop_move_valid?(piece, target_x, target_y)
    diagonal_path_clear?(piece, target_x, target_y) &&
      (capture_move_valid?(piece, target_x, target_y) || board.grid[target_y][target_x].nil?)
  end

  def pawn_move_valid?(piece, target_x, target_y)
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
  end

  def rook_move_valid?(piece, target_x, target_y)
    # doesn't account for castling
    straight_path_clear?(piece, target_x, target_y) &&
      (capture_move_valid?(piece, target_x, target_y) || board.grid[target_y][target_x].nil?)
  end

  def straight_path_clear?(piece, target_x, target_y)
    path_range = []

    if piece.position[0] = target_x
      y_mod = target_y > piece.position[1] ? 1 : -1
      steps = (target_y - piece.position[1]).abs
      (1...steps).each do |index|
        path_range << [piece.position[0], piece.position[1] + (y_mod * index)]
      end

    else
      x_mod = target_x > piece.position[0] ? 1 : -1
      steps = (target_x - piece.position[0]).abs
      (1...steps).each do |index|
        path_range << [piece.position[0] + (x_mod * index), piece.position[1]]
      end
    end

    path_range.all? { |x, y|  board.grid[y][x].nil? }
  end

  def diagonal_path_clear?(piece, target_x, target_y)
    x_mod = target_x > piece.position[0] ? 1 : -1
    y_mod = target_y > piece.position[1] ? 1 : -1
    path_range = []

    steps = (target_x - piece.position[0]).abs
    (1...steps).each do |index|
      path_range << [piece.position[0] + (x_mod * index), piece.position[1] + (y_mod * index)]
    end

    path_range.all? { |x, y|  board.grid[y][x].nil? }
  end

  def queen_move_valid?(piece, target_x, target_y)
    path_clear = if piece.position[x] == target_x || piece.position[y] == target_y
                   straight_path_clear?(piece, target_x, target_y)
                 else
                   diagonal_path_clear?(piece, target_x, target_y)
                 end
    path_clear && (capture_move_valid?(piece, target_x, target_y) || board.grid[target_y][target_x].nil?)
  end

  def king_move_valid?(piece, target_x, target_y)
    capture_move_valid?(piece, target_x, target_y) || board.grid[target_y][target_x].nil?
  end

end
