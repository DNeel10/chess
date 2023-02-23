require_relative 'board'
require_relative 'movement'

class Pawn
  attr_accessor :moves, :position, :first_move
  attr_reader :color, :attacking_moves, :name, :white_move_pattern, :board,
              :black_move_pattern, :black_attacking_moves, :white_attacking_moves, :symbol

  include Movement

  def initialize(position, color, board)
    @position = position
    @board = board
    @color = color
    @name = 'Pawn'
    @symbol = to_symbol
    @fen = to_fen
    @first_move = true
    @white_move_pattern = [[1, 0], [2, 0]]
    @black_move_pattern = [[-1, 0], [-2, 0]]
    @white_attacking_moves = [[1, 1], [1, -1]]
    @black_attacking_moves = [[-1, 1], [-1, -1]]
    @moves = []

  end

  def to_s
    "#{@symbol}"
  end

  def to_symbol
    color == 'White' ? '♙' : '♟︎'
  end

  def to_fen
    color == 'White' ? 'P' : 'p'
  end

  def valid_moves
    @moves = []

    case first_move
    when true
      initial_move
    else
      move_one_space
    end
    attack_moves
  end

  def move_one_space
    case color
    when 'White'
      new_move = [position[0] + white_move_pattern.first[0], position[1] + white_move_pattern.first[1]]
    else
      new_move = [position[0] + black_move_pattern.first[0], position[1] + black_move_pattern.first[1]]
    end
    # puts "#{color} #{position} #{new_move}"   WHAT IS GOING ON??
    moves << new_move if new_move.all? { |n| n >= 0 && n <= 7 } && board.open_space?(new_move)
  end

  def initial_move
    case color
    when 'White'
      white_initial_moves
    else
      black_initial_moves
    end
  end

  def attack_moves
    case color
    when 'White'
      white_attack_moves
    else
      black_attack_moves
    end
  end

  def promote_piece(rank, file)
    board.remove_piece([rank, file])

    puts "Which piece would you like to promote to?"
    puts 'Please select [Queen], [Rook], [Bishop], or [Knight]'
    
    loop do

      promoted_piece = gets.chomp.downcase

      case promoted_piece
      when 'queen'
        return board.update_piece([rank, file], Queen.new([rank, file], color, board))
      when 'rook'
        return board.update_piece([rank, file], Rook.new([rank, file], color, board))
      when 'knight'
        return board.update_piece([rank, file], Knight.new([rank, file], color, board))
      when 'bishop'
        return board.update_piece([rank, file], Bishop.new([rank, file], color, board))
      else
        puts 'That is not a valid promotion. Please select a valid piece'
      end
    end

  end

  def white_initial_moves
    white_move_pattern.map { |x, y| [position[0] + x, position[1] + y] }
                      .each { |move| moves << move if move.all? { |n| n >= 0 && n <= 7 } && board.open_space?(move) }
  end

  def black_initial_moves
    black_move_pattern.map { |x, y| [position[0] + x, position[1] + y] }
                      .each { |move| moves << move if move.all? { |n| n >= 0 && n <= 7 } && board.open_space?(move) }
  end

  def white_attack_moves
    # TODO : build moves to attack opponent pieces if diagonal
    white_attacking_moves.map { |x, y| [position[0] + x, position[1] + y] }
                         .each { |move| moves << move if move.all? { |n| n >= 0 && n <= 7 } && board.opponent_piece?(move, color) }
  end

  def black_attack_moves
    # TODO : build moves to attack opponent pieces if diagonal
    black_attacking_moves.map { |x, y| [position[0] + x, position[1] + y] }
                         .each { |move| moves << move if (move.all? { |n| n >= 0 && n <= 7 } && board.opponent_piece?(move, color)) }
  end

  def valid_selection?(coordinates, moves = @moves)
    moves.include?(coordinates)
  end

  def legal_moves
    @moves.reject! { |move| moves_expose_king?(move, position) }
  end

  def update_position(coordinates)
    @position = coordinates
    rank, file = @position
    @first_move = false
    promote_piece(rank, file) if rank == 7 || rank == 0

    @moves = []
    legal_moves
  end
end
