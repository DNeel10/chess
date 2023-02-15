require_relative 'checkfinder'

class King
  attr_reader :move_pattern, :color, :name, :symbol
  attr_accessor :position, :moves, :board, :check_finder, :check

  # what needs to be set up when a piece is created in the game
  def initialize(position, color, board)
    @position = position
    @color = color
    @board = board
    @name = 'King'
    @symbol = to_fen
    @move_pattern = [[0, 1], [1, 0], [0, -1], [-1, 0],
                     [1, 1], [1, -1], [-1, 1], [-1, -1]]
    @moves = []
    @check_finder = Checkfinder.new(board)
    @check = currently_in_check?
  end

  def to_s
    "#{@symbol}"
  end

  def to_fen
    color == 'White' ? '♔' : '♚'
  end

  def valid_moves
    @moves = []

    potential_moves.each do |move|
      if board.open_space?(move)
        moves << move unless check_finder.would_be_in_check?(self, move) == true
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

  def legal_move?(coordinates, moves = @moves)
    moves.include?(coordinates)
  end

  def update_position(coordinates)
    @position = coordinates
    @moves = []
    valid_moves
  end

  def currently_in_check?
    check_finder.in_check?(self)
  end
end
