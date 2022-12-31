class Pawn
  attr_reader :color, :position, :moves, :attacking_moves

  def initialize(position, color)
    @position = position
    @color = color
    @first_move = true
    @moves = [[1, 0], [2, 0]]
    @attacking_moves = [[1, 1], [1, -1]]
  end
end