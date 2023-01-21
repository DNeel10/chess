class Pawn
  attr_reader :color, :position, :moves, :attacking_moves

  def initialize(position, color)
    @position = position
    @color = color
    @first_move = true
    @white_move_pattern = [[1, 0], [2, 0]]
    @black_move_pattern = [[-1, 0], [-2, 0]]
    @white_attacking_moves = [[1, 1], [1, -1]]
    @black_attacking_moves = [[-1, 1], [-1, -1]]
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

  def potential_moves
    move_pattern.map { |x, y| [position[0] + x, position[1] + y] }
                .select { |move| move.all? { |n| n >= 0 && n <= 7 } }
  end
end
