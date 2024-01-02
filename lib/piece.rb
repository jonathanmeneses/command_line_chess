# frozen_string_literal: true

class Piece

  def initialize(color,location)
    @color = color
    #location is alphanumeric
    @location = location
  end

  def update_location(new_location)
    #Require an alphanumeric location
    @location = new_location
  end

end
