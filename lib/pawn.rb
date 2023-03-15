require_relative 'board'
require_relative 'movement'
require_relative 'piece'

class Pawn < Piece
  attr_accessor :moves, :position, :first_move, :previous_position
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
    @previous_position = position
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
    
    add_en_passant_moves

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

  def add_en_passant_moves
    curr_rank, curr_file = @position
    case @color
    when 'White'
      return if curr_rank != 4
      white_left_en_passant(curr_rank, curr_file)
      white_right_en_passant(curr_rank, curr_file)
    else
      return if curr_rank != 3
      black_left_en_passant(curr_rank, curr_file)
      black_right_en_passant(curr_rank, curr_file)
    end
    # white rank: 4, black rank: 3
    # board.last_moved_piece == piece being captured && piece.is_a?(Pawn)
    # white board.last_moved_piece.previous_rank == 6, black board.last_moved_piece.previous_rank == 1
  end

  def make_en_passant_move(rank, file)
    board.remove_piece([rank, file])

  end

  def white_left_en_passant(curr_rank, curr_file)
    return if board.grid[curr_rank][curr_file - 1].nil?

    if board.grid[curr_rank][curr_file - 1].is_a?(Pawn) && board.grid[curr_rank][curr_file - 1] == board.last_moved_piece
      @moves << [curr_rank + 1, curr_file - 1] if board.grid[curr_rank][curr_file - 1].previous_position[0] == 6
    end
  end

  def white_right_en_passant(curr_rank, curr_file)
    return if board.grid[curr_rank][curr_file + 1].nil?

    if board.grid[curr_rank][curr_file + 1].is_a?(Pawn) && board.grid[curr_rank][curr_file + 1] == board.last_moved_piece
      @moves << [curr_rank + 1, curr_file + 1] if board.grid[curr_rank][curr_file + 1].previous_position[0] == 6
    end
  end

  def black_left_en_passant(curr_rank, curr_file)
    return if board.grid[curr_rank][curr_file - 1].nil?

    if board.grid[curr_rank][curr_file - 1].is_a?(Pawn) && board.grid[curr_rank][curr_file - 1] == board.last_moved_piece
      @moves << [curr_rank - 1, curr_file - 1] if board.grid[curr_rank][curr_file - 1].previous_position[0] == 1
    end
  end

  def black_right_en_passant(curr_rank, curr_file)
    return if board.grid[curr_rank][curr_file + 1].nil?

    if board.grid[curr_rank][curr_file + 1].is_a?(Pawn) && board.grid[curr_rank][curr_file + 1] == board.last_moved_piece
      @moves << [curr_rank - 1, curr_file + 1] if board.grid[curr_rank][curr_file + 1].previous_position[0] == 1
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
    # build moves to attack opponent pieces if diagonal
    white_attacking_moves.map { |x, y| [position[0] + x, position[1] + y] }
                         .each { |move| moves << move if move.all? { |n| n >= 0 && n <= 7 } && board.opponent_piece?(move, color) }
  end

  def black_attack_moves
    # build moves to attack opponent pieces if diagonal
    black_attacking_moves.map { |x, y| [position[0] + x, position[1] + y] }
                         .each { |move| moves << move if (move.all? { |n| n >= 0 && n <= 7 } && board.opponent_piece?(move, color)) }
  end

  def valid_selection?(coordinates, moves = @moves)
    moves.include?(coordinates)
  end

  def update_position(coordinates)
    c_rank, c_file = coordinates
    @position = coordinates
    p_rank, p_file = @position
    @first_move = false
    board.last_moved_piece = self
    promote_piece(p_rank, p_file) if p_rank == 7 || p_rank == 0
    make_en_passant_move(c_rank - 1, c_file) if board.grid[c_rank - 1][c_file].is_a?(Pawn) && board.opponent_piece?([c_rank - 1, c_file], color)
    make_en_passant_move(c_rank + 1, c_file) if board.grid[c_rank + 1][c_file].is_a?(Pawn) && board.opponent_piece?([c_rank + 1, c_file], color)
    @moves = []
  end
end
