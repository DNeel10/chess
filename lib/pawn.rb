require_relative 'board'

class Pawn
  attr_accessor :moves
  attr_reader :color, :position, :attacking_moves, :name, :white_move_pattern,
              :black_move_pattern, :black_attacking_moves, :white_attacking_moves, :first_move

  def initialize(position, color, board)
    @position = position
    @color = color
    @name = 'Pawn'
    @first_move = true
    @white_move_pattern = [[1, 0], [2, 0]]
    @black_move_pattern = [[-1, 0], [-2, 0]]
    @white_attacking_moves = [[1, 1], [1, -1]]
    @black_attacking_moves = [[-1, 1], [-1, -1]]
    @moves = []
    # valid_moves(board)
  end

  def to_s
    "#{@name}, #{@position}"
  end

  def valid_moves(board, moves = @moves)
    if @first_move == false
      move_one_space(board)
    else
      initial_move(board)
      @first_move = false
    end
  end

  def move_one_space(board = @board, position = @position, color = @color, moves = @moves)
    case color
    when 'White'
      new_move = [position[0] + white_move_pattern.first[0], position[1] + white_move_pattern.first[1]]
    else
      new_move = [position[0] + black_move_pattern.first[0], position[1] + black_move_pattern.first[1]]
    end
    moves << new_move if board.open_space?(new_move)
  end

  def initial_move(board = @board, position = @position, color = @color, moves = @moves)
    case color
    when 'White'
      white_move_pattern.map { |x, y| [position[0] + x, position[1] + y] }
                        .each { |move| moves << move if move.all? { |n| n >= 0 && n <= 7 } && board.open_space?(move) }
    else
      black_move_pattern.map { |x, y| [position[0] + x, position[1] + y] }
                        .each { |move| moves << move if move.all? { |n| n >= 0 && n <= 7 } && board.open_space?(move) }
    end
  end

  def update_position(coordinates)
    @position = coordinates
    @moves = []
    valid_moves(board)
  end
end

board = Board.new
pawn = Pawn.new([1,0], 'White', board)

p pawn.moves