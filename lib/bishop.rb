require_relative 'movement'
require_relative 'piece'

class Bishop < Piece
  attr_reader :move_pattern, :color, :symbol
  attr_accessor :position, :moves, :name, :board
  
  include Movement

  # what needs to be set up when a piece is created in the game
  def initialize(position, color, board)
    @position = position
    @color = color
    @board = board
    @name = 'Bishop'
    @symbol = to_symbol
    @fen = to_fen
    @move_pattern = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
    @moves = []
  end

  def to_s
    "#{@symbol}"
  end

  def to_symbol
    color == 'White' ? '♗' : '♝'
  end

  def to_fen
    color == 'White' ? 'B' : 'b'
  end

  def valid_moves(moves = @moves)
    @moves = []

    move_up_right
    move_up_left
    move_down_right
    move_down_left
    moves
  end
end
