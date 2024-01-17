# frozen_string_literal: true

require 'pry-byebug'
require 'colorize'

# Board class for chess
class Board
  attr_accessor :grid, :alpha_map

  def initialize
    # A8 is "top left" and H1 is "bottom right"
    @grid = Array.new(8) { Array.new(8, nil) }
    @alpha_map = ("a".."h").to_a
  end

  def display_board
    puts '    A  B  C  D  E  F  G  H '
    puts '----------------------------'
    @grid.reverse.each_with_index do |row, row_index|
      row_number = 8 - row_index
      print_view = " #{row_number} "
      row.each_with_index do |cell, col_index|
        background_color = (row_index + col_index).even? ? :light_black : :light_white
        cell_content = cell.nil? ? '   ' : " #{cell.display_icon} "
        print_view += cell_content.colorize(background: background_color)
      end
      print_view += " #{row_number} "
      puts print_view
    end
    puts '----------------------------'
    puts '    A  B  C  D  E  F  G  H '
  end

  def update_board_square(x,y,piece)
    if (x.negative? || y.negative? || x > (grid.length - 1)) || (y > (grid.length - 1))
      raise RangeError, 'Invalid Cell Selection'
    end

    @grid[y][x] = piece
  end


  def deep_clone
    new_board = Board.new
    grid.each_with_index do |row, y|
      row.each_with_index do |piece, x|
        next if piece.nil?
        new_piece = piece.clone
        new_board.update_board_square(x,y,new_piece)
        new_piece.position = [x,y]
      end
    end
    new_board
  end

  def array_to_alphanumeric_notation(x,y)
    if x.negative? || y.negative? || x > (grid[0].length - 1) || y > (grid.length - 1)
      raise RangeError, 'Array columns out of range'
    end

    alpha_map[x] + (y+1).to_s
  end

  def alphanumeric_to_array_notation(space)
    unless space.length == 2
      raise ArgumentError, 'Alphanumeric space is not 2 characters'
    end
    unless alpha_map.include?(space[0]) && space[1].to_i < (1 + grid.length) && space[1].to_i > 0
      raise ArgumentError, 'Alphanumeric selection out of range'
    end

    [alpha_map.index(space[0]), (space[1].to_i - 1)]
  end
end
