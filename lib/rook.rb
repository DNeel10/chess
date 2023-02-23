require_relative 'board'
require_relative 'movement'
require_relative 'piece'

class Rook < Piece
  attr_reader :move_pattern, :color, :name, :board, :symbol
  attr_accessor :position, :moves, :can_castle

  include Movement

  # what needs to be set up when a piece is created in the game
  def initialize(position, color, board)
    @position = position
    @color = color
    @board = board
    @name = 'Rook'
    @symbol = to_symbol
    @fen = to_fen
    @move_pattern = [[0, 1], [1, 0], [0, -1], [-1, 0]]
    @can_castle = true
    @moves = []
  end

  def to_s
    "#{@symbol}"
  end

  def to_symbol
    color == 'White' ? '♖' : '♜'
  end

  def to_fen
    color == 'White' ? 'R' : 'r'
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

  def update_position(coordinates)
    super
    @can_castle = false
    puts "can castle: #{@can_castle}, pos: #{@position}"
  end
end
