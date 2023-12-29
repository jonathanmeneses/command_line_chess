# frozen_string_literal: true

require 'pry-byebug'

# Board class for chess
class Board
  attr_accessor :grid

  def initialize()
    @grid = Array.new(8) { Array.new(8, nil) }
  end
end
