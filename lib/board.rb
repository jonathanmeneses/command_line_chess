# frozen_string_literal: true

require 'pry-byebug'

# Board class for chess
class Board
  attr_accessor :grid, :alpha_map

  def initialize
    # A1 is "top left" and H8 is "bottom right"
    @grid = Array.new(8) { Array.new(8, nil) }
    @alpha_map = ("a".."h").to_a
  end

  def display_board
    puts '   | A | B | C | D | E | F | G | H |'
    puts '------------------------------------'
    @grid.each_with_index do |row, index|
      print_view = " #{index+1} |"
      row.each do |cell|
        print_view += (cell.nil? ? '   |' : " #{cell.display_icon} |")
      end
      puts print_view
    end
    puts '------------------------------------'
    puts '   | A | B | C | D | E | F | G | H |'
  end

  def update_board_square(x,y,piece)
    if (x.negative? || y.negative? || x > (grid.length - 1)) || (y > (grid.length - 1))
      raise RangeError, 'Invalid Cell Selection'
    end

    @grid[y][x] = piece
  end

  def array_to_alphanumeric_notation(x,y)
    if x.negative? || y.negative? || x > (grid[0].length - 1) || y > (grid.length - 1)
      raise RangeError, 'Array columns out of range'
    end

    alpha_map[x] + (y+1).to_s
  end

  def alphanumeric_to_array_notation(space)
    unless space.length == 2 && alpha_map.include?(space[0]) && space[1].to_i < grid.length
      raise ArgumentError, 'Alphanumeric space is not 2 characters'
    end

    [alpha_map.index(space[0]), (space[1].to_i - 1)]
  end
end
