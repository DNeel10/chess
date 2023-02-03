require_relative 'board'

class Pawn
  attr_accessor :moves, :position, :first_move
  attr_reader :color, :attacking_moves, :name, :white_move_pattern, :board,
              :black_move_pattern, :black_attacking_moves, :white_attacking_moves

  def initialize(position, color, board)
    @position = position
    @board = board
    @color = color
    @name = 'Pawn'
    @first_move = true
    @white_move_pattern = [[1, 0], [2, 0]]
    @black_move_pattern = [[-1, 0], [-2, 0]]
    @white_attacking_moves = [[1, 1], [1, -1]]
    @black_attacking_moves = [[-1, 1], [-1, -1]]
    @moves = []
    valid_moves
  end

  def to_s
    "#{@name}, #{@position}, #{first_move}"
  end

  def valid_moves
    @moves = []
    case first_move
    when true
      initial_move
    else
      move_one_space
    end
    # attack_moves(board)
  end

  def move_one_space
    case color
    when 'White'
      new_move = [position[0] + white_move_pattern.first[0], position[1] + white_move_pattern.first[1]]
    else
      new_move = [position[0] + black_move_pattern.first[0], position[1] + black_move_pattern.first[1]]
    end
    moves << new_move if board.open_space?(new_move)
  end

  def initial_move
    case color
    when 'White'
      white_move_pattern.map { |x, y| [position[0] + x, position[1] + y] }
                        .each { |move| moves << move if move.all? { |n| n >= 0 && n <= 7 } && board.open_space?(move) }
    else
      black_move_pattern.map { |x, y| [position[0] + x, position[1] + y] }
                        .each { |move| moves << move if move.all? { |n| n >= 0 && n <= 7 } && board.open_space?(move) }
    end
  end

  def attack_moves(board, position = @position, color = @color, moves = @moves)
    # TODO : build moves to attack opponent pieces if diagonal
  end

  def legal_move?(coordinates, moves = @moves)
    moves.include?(coordinates)
  end

  def update_position(coordinates)
    @position = coordinates
    @first_move = false
    @moves = []
    valid_moves
  end
end
