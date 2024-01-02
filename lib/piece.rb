# frozen_string_literal: true


class Piece

  def initialize(color,position)
    @color = color
    #location is array [x,y] location
    @position = position
  end

  def update_location(new_location)
    #Require an array [x,y] location
    @position = new_location
  end

end
