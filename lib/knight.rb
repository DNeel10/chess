class Knight
  attr_reader :move_pattern, :color
  attr_accessor :position, :moves

  # what needs to be set up when a piece is created in the game
  def initialize(position, color)
    @position = position
    @color = color
    @move_pattern = [[1, 2], [1, -2], [-1, 2], [-1, -2],
                     [2, 1], [2, -1], [-2, 1], [-2, -1]]
    @moves = []
  end

  def valid_moves(board, moves = @moves)
    potential_moves.each do |move|
      if board.open_space?(move)
        moves << move
      else
        moves << move unless board.players_piece?(move, color)
      end
    end
    moves
  end

  def potential_moves(position = @position)
    move_pattern.map { |x, y| [position[0] + x, position[1] + y] }
                .select { |move| move.all? { |n| n >= 0 && n <= 7 } }
  end

  def legal_move?(coordinates, moves = @moves)
    moves.include?(coordinates)
  end

  def update_position(coordinates)
    @position = coordinates
    @moves = []
    valid_moves(board)
  end

end
