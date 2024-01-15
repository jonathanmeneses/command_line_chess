# frozen_string_literal: true


class Piece

  def initialize(position ,color, board)
    @color = color
    #location is array [x,y] location with [0,0] being "A1"
    @position = position
  end

  def update_location(new_location)
    #Require an array [x,y] location
    @position = new_location
  end

end
