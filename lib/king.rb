require_relative 'checkfinder'
require_relative 'movement'
require_relative 'piece'
require_relative 'evaluation'

class King < Piece
  attr_reader :move_pattern, :color, :name, :symbol
  attr_accessor :position, :moves, :board, :check_finder, :check, :can_castle

  include Movement

  # what needs to be set up when a piece is created in the game
  def initialize(position, color, board)
    @position = position
    @color = color
    @board = board
    @name = 'King'
    @symbol = to_symbol
    @fen = to_fen
    @move_pattern = [[0, 1], [1, 0], [0, -1], [-1, 0],
                     [1, 1], [1, -1], [-1, 1], [-1, -1]]
    @moves = []
    @check_finder = Checkfinder.new(board)
    @check = currently_in_check?
    @can_castle = true
  end

  def to_s
    "#{@symbol}"
  end

  def to_symbol
    color == 'White' ? '♔' : '♚'
  end

  def to_fen
    color == 'White' ? 'K' : 'k'
  end

  def valid_moves
    @moves = []

    king_step_moves
    add_castle_moves

    moves
  end

  def currently_in_check?
    check_finder.in_check?(self)
  end

  def update_position(coordinates)
    rank, file = coordinates
    # figure out condition to run make_castle_moves
    make_castle_move(rank, file) if board.grid[rank][file].is_a?(Rook)

    @position = [rank, file]

    @can_castle = false

  end

  def make_castle_move(rank, file)
    board.remove_piece([rank, file])
    if file == 7
      board.update_piece([rank, 6], self)
      board.update_piece([rank, 5], Rook.new([rank, 5], color, board))
    elsif file == 0
      board.update_piece([rank, 2], self)
      board.update_piece([rank, 3], Rook.new([rank, 3], color, board))
    end
  end

  def add_castle_moves
    case @color
    when 'White'
      moves << [0, 0] if queen_side_can_castle? && @can_castle
      moves << [0, 7] if king_side_can_castle? && @can_castle
    else
      moves << [7, 0] if queen_side_can_castle? && @can_castle
      moves << [7, 7] if king_side_can_castle? && @can_castle
    end
  end

  def king_side_open?
    case @color
    when 'White'
      castle_rank = 0
      return true if board.grid[castle_rank][5].nil? && 
                     board.grid[castle_rank][6].nil?
    else
      castle_rank = 7
      return true if board.grid[castle_rank][5].nil? && 
                     board.grid[castle_rank][6].nil?
    end
    false
  end

  def king_side_can_castle?
    return false unless king_side_rook && king_side_rook.can_castle == true

    king_side_open? && !king_side_being_attacked?
  end

  def king_side_being_attacked?
    case @color
    when 'White'
      castle_rank = 0
      Evaluation.new(@board, @color).moves_expose_king?([castle_rank, 5], @position, @color) ||
        Evaluation.new(@board, @color).moves_expose_king?([castle_rank, 6], @position, @color)
    else
      castle_rank = 7
      Evaluation.new(@board, @color).moves_expose_king?([castle_rank, 5], @position, @color) ||
        Evaluation.new(@board, @color).moves_expose_king?([castle_rank, 6], @position, @color)
    end
  end

  def king_side_rook
    case @color
    when 'White'
      castle_rank = 0
      piece = board.grid[castle_rank][7]
      return piece if piece.is_a?(Rook)
    else
      castle_rank = 7
      piece = board.grid[castle_rank][7]
      return piece if piece.is_a?(Rook)
    end
  end

  def queen_side_rook
    case @color
    when 'White'
      castle_rank = 0
      piece = board.grid[castle_rank][0]
      return piece if piece.is_a?(Rook)
    else
      castle_rank = 7
      piece = board.grid[castle_rank][0]
      return piece if piece.is_a?(Rook)
    end
  end

  def queen_side_can_castle?
    return false unless queen_side_rook && queen_side_rook.can_castle

    queen_side_open? && !queen_side_being_attacked?
  end

  def queen_side_open?
    case @color
    when 'White'
      castle_rank = 0
      return true if board.grid[castle_rank][3].nil? && board.grid[castle_rank][2].nil? && board.grid[castle_rank][1].nil?
    else
      castle_rank = 7
      return true if board.grid[castle_rank][3].nil? && board.grid[castle_rank][2].nil? && board.grid[castle_rank][1].nil?
    end
    false
  end

  def queen_side_being_attacked?
    case @color
    when 'White'
      castle_rank = 0
      Evaluation.new(@board, @color).moves_expose_king?([castle_rank, 3], @position, @color) ||
        Evaluation.new(@board, @color).moves_expose_king?([castle_rank, 2], @position, @color) ||
          Evaluation.new(@board, @color).moves_expose_king?([castle_rank, 1], @position, @color)
    else
      castle_rank = 7
      Evaluation.new(@board, @color).moves_expose_king?([castle_rank, 3], @position, @color) ||
        Evaluation.new(@board, @color).moves_expose_king?([castle_rank, 2], @position, @color) ||
          Evaluation.new(@board, @color).moves_expose_king?([castle_rank, 1], @position, @color)
    end
  end
end
