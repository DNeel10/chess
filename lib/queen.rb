class Queen
  attr_reader :move_pattern, :color
  attr_accessor :position

  # what needs to be set up when a piece is created in the game
  def initialize(position, color)
    @position = position
    @color = color
    @move_pattern = [[0, 1], [1, 0], [0, -1], [-1, 0],
                     [1, 1], [1, -1], [-1, 1], [-1, -1]]
  end

  def valid_moves(board)

  end

  # queen can use move pattern in any direction up to where another piece is (capturing, or one before)
  def potential_moves

  end

  def legal_move?(board, coordinates)
    valid_moves(board).include?(coordinates)
  end

end
