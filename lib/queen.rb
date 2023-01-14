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
    valid_moves_list = []
    potential_moves.each do |move|
      if board[move[0]][move[1]].nil?
        valid_moves_list << move
      else
        valid_moves_list << move unless board[move[0]][move[1]].color == @color
      end
    end
    valid_moves_list
  end

  # queen can use move pattern in any direction up to where another piece is (capturing, or one before)
  def potential_moves
    move_pattern.map { |x, y| [position[0] + x, position[1] + y] }
                .select { |move| move.all? { |n| n >= 0 && n <= 7 } }
  end

  def legal_move?(board, coordinates)
    valid_moves(board).include?(coordinates)
  end

end
