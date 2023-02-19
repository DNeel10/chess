require_relative 'movement'

class Knight
  attr_reader :move_pattern, :color, :name, :symbol
  attr_accessor :position, :moves, :board

  include Movement

  # what needs to be set up when a piece is created in the game
  def initialize(position, color, board)
    @position = position
    @color = color
    @board = board
    @name = 'Knight'
    @symbol = to_fen
    @move_pattern = [[1, 2], [1, -2], [-1, 2], [-1, -2],
                     [2, 1], [2, -1], [-2, 1], [-2, -1]]
    @moves = []
  end

  def to_s
    "#{@symbol}"
  end

  def to_fen
    color == 'White' ? '♘' : '♞'
  end

  def valid_moves
    @moves = []

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

  def valid_selection?(coordinates, moves = @moves)
    moves.include?(coordinates)
  end

  def legal_moves
    @moves.reject! { |move| moves_expose_king?(move, position) }
  end

  def update_position(coordinates)
    @position = coordinates
    legal_moves
  end
end
