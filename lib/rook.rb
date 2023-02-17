require_relative 'board'
require_relative 'movement'

class Rook
  attr_reader :move_pattern, :color, :name, :board, :symbol
  attr_accessor :position, :moves

  include Movement

  # what needs to be set up when a piece is created in the game
  def initialize(position, color, board)
    @position = position
    @color = color
    @board = board
    @name = 'Rook'
    @symbol = to_fen
    @move_pattern = [[0, 1], [1, 0], [0, -1], [-1, 0]]
    @moves = []
  end

  def to_s
    "#{@symbol}"
  end

  def to_fen
    color == 'White' ? '♖' : '♜'
  end

  # rook can use move pattern in one (up, down, left, right) direction up to where another piece is
  # (capturing, or one before)
  def valid_moves(moves = @moves)
    @moves = []

    move_right
    move_left
    move_up
    move_down
    moves
  end

  def legal_move?(coordinates, moves = @moves)
    moves.include?(coordinates)
  end

  def update_position(coordinates)
    @position = coordinates
    @moves = []
    valid_moves
  end
end
