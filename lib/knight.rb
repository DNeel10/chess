require_relative 'movement'
require_relative 'piece'

class Knight < Piece
  attr_reader :move_pattern, :color, :name, :symbol
  attr_accessor :position, :moves, :board

  include Movement

  # what needs to be set up when a piece is created in the game
  def initialize(position, color, board)
    @position = position
    @color = color
    @board = board
    @name = 'Knight'
    @symbol = to_symbol
    @fen = to_fen
    @move_pattern = [[1, 2], [1, -2], [-1, 2], [-1, -2],
                     [2, 1], [2, -1], [-2, 1], [-2, -1]]
    @moves = []
  end

  def to_s
    "#{@symbol}"
  end

  def to_symbol
    color == 'White' ? '♘' : '♞'
  end

  def to_fen
    color == 'White' ? 'N' : 'n'
  end

  def valid_moves
    @moves = []

    step_moves

    moves
  end
end
