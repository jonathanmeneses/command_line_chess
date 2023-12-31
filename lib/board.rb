# frozen_string_literal: true

require 'pry-byebug'

# Board class for chess
class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8, nil) }
  end

  def display_board
    puts '   | A | B | C | D | E | F | G | H |'
    puts '------------------------------------'
    @grid.each_with_index do |row, index|
      print_view = " #{index+1} |"
      row.each do |cell|
        print_view += (cell.nil? ? '   |' : " #{cell} |")
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

end