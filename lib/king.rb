class King
  attr_reader :move_pattern, :color
  attr_accessor :position

  # what needs to be set up when a piece is created in the game
  def initialize(position, color)
    @position = position
    @color = color
    @move_pattern = [[0, 1], [1, 0], [0, -1], [-1, 0],
                     [1, 1], [1, -1], [-1, 1], [-1, -1]]
    @moves = []
    @check = false
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

  def potential_moves
    move_pattern.map { |x, y| [position[0] + x, position[1] + y] }
                .select { |move| move.all? { |n| n >= 0 && n <= 7 } }
  end

  def legal_move?(board, coordinates)
    valid_moves(board).include?(coordinates)
  end

  def update_position(coordinates)
    @position = coordinates
    @moves = []
    valid_moves(board)
  end

end
