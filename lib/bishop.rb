class Knight
  attr_reader :move_pattern, :color
  attr_accessor :position

  # what needs to be set up when a piece is created in the game
  def initialize(position, color)
    @position = position
    @color = color
    @move_pattern = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
  end

  def valid_moves(board)

  end

  # bishop can move diagonal up to capturing a piece
  def potential_moves

  end

  def legal_move?(board, coordinates)
    valid_moves(board).include?(coordinates)
  end

end
