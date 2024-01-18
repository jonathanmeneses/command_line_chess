# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize

require_relative '../lib/piece'

# Pawn Piece
class Pawn < Piece
  attr_accessor :position, :color, :display_icon

  def initialize(position, color)
    super(position, color)
    @display_icon = color == :white ? '♗' : '♟︎'
  end

  def potential_moves()
    #shows moves in array format
    moves = []

    forward_steps = initial_row? ? 2 : 1
    direction = color == :white ? 1 : -1

    #forward moves
    1.upto(forward_steps) do |step|
      moves << [position[0], position[1] + step * direction]
    end
    #diagonal and en passant moves
    moves << [position[0] + 1, position[1] +  direction]
    moves << [position[0] - 1, position[1] +  direction]

    moves.select {|x,y| x.between?(0,7) && y.between?(0,7)}
  end

  private

  def initial_row?
    (color == :white && position[1] == 1) || (color == :black && position[1] == 6)
  end

end

class Bishop < Piece
  attr_accessor :position, :color, :display_icon

  def initialize(position, color)
    super(position, color)
    @display_icon = color == :white ? '♗' : '♝'
  end

  def potential_moves()
    #shows moves in array format
    moves = []

    1.upto(7) do |step|
      moves << [position[0] + step, position[1] + step]
      moves << [position[0] + step, position[1] - step]
      moves << [position[0] - step, position[1] - step]
      moves << [position[0] - step, position[1] + step]
    end

    moves.select {|x,y| x.between?(0,7) && y.between?(0,7)}
  end

end

class Knight < Piece
  attr_accessor :position, :color, :display_icon

  def initialize(position, color)
    super(position, color)
    @display_icon = color == :white ? '♘' : '♞'
  end

  def potential_moves()
    #shows moves in array format
    move_vectors = [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]]
    moves = move_vectors.map { |x, y| [position[0] + x, position[1] + y] }

    moves.select {|x,y| x.between?(0,7) && y.between?(0,7)}
  end

end

class Rook < Piece
  attr_accessor :position, :color, :display_icon

  def initialize(position, color)
    super(position, color)
    @display_icon = color == :white ? '♖' : '♜'
  end

  def potential_moves()
    #shows moves in array format
    moves = []

    1.upto(7) do |step|
      moves << [position[0] + step, position[1]]
      moves << [position[0] - step, position[1]]
      moves << [position[0], position[1] + step]
      moves << [position[0], position[1] - step]
    end

    moves.select {|x,y| x.between?(0,7) && y.between?(0,7)}
  end

end

class King < Piece
  #still need to introduce castling
  attr_accessor :position, :color, :display_icon

  def initialize(position, color)
    super(position, color)
    @display_icon = color == :white ? '♔': '♚'
  end

  def potential_moves()
    #shows moves in array format

    move_vectors = [[1, 1], [1, -1], [-1, 1], [-1, -1], [1, 0], [-1, 0], [-1, 1], [0, -1]]
    moves = move_vectors.map { |x, y| [position[0] + x, position[1] + y] }

    moves.select {|x,y| x.between?(0,7) && y.between?(0,7)}
  end

end

class Queen < Piece
  attr_accessor :position, :color, :display_icon

  def initialize(position, color)
    super(position, color)
    @display_icon = color == :white ? '♕' : '♛'
  end

  def potential_moves()
    #shows moves in array format
    moves = []

    move_vectors = [[1, 1], [1, -1], [-1, 1], [-1, -1], [1,0],[-1,0],[0,1],[0,-1]]
    move_vectors.each do |x, y|
      1.upto(7) do |step|
        moves << [position[0] + x * step, position[1] + y * step]
      end
    end

    moves.select { |x,y| x.between?(0, 7) && y.between?(0, 7) }
  end

end
