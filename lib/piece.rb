# Super class for all pieces

class Piece
  attr_accessor :position, :color, :board

  def initialize(position, color, board)
    @position = position
    @color = color
    @board = board
  end

  def valid_moves
    moves
  end
end