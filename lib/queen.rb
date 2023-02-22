require_relative 'movement'
require_relative 'piece'

class Queen < Piece
  attr_reader :move_pattern, :color, :name, :symbol
  attr_accessor :position, :moves, :board, :check_finder

  include Movement
  # what needs to be set up when a piece is created in the game
  def initialize(position, color, board)
    @position = position
    @color = color
    @board = board
    @name = 'Queen'
    @symbol = to_fen
    @move_pattern = [[0, 1], [1, 0], [0, -1], [-1, 0],
                     [1, 1], [1, -1], [-1, 1], [-1, -1]]
    @moves = []
  end

  def to_s
    "#{@symbol}"
  end

  def to_fen
    color == 'White' ? '♕' : '♛'
  end

  def valid_moves
    @moves = []

    move_right
    move_left
    move_up
    move_down
    move_up_right
    move_up_left
    move_down_right
    move_down_left
    moves
  end
end
