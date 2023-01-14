class Pawn
  attr_reader :color, :position, :moves, :attacking_moves

  def initialize(position, color)
    @position = position
    @color = color
    @move_pattern = [[1, 0], [2, 0]]
    @first_move = true
    @attacking_moves = [[1, 1], [1, -1]]
  end

  def valid_moves(board)
    valid_moves_list = []
    initial_move_list = potential_moves
    initial_move_list.each do |move|
      if board[move[0]][move[1]].nil?
        valid_moves_list << move
      else
        valid_moves_list << move unless board[move[0]][move[1]].color == @color
      end
    end
    valid_moves_list
  end

  def potential_moves
    move_pattern.map { |x, y| [position[0] + x, position[1] + y] }
                .select { |move| move.all? { |n| n >= 0 && n <= 7 } }
  end
end
