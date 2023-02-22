require_relative 'checkfinder'
require_relative 'movement'
require_relative 'piece'

class King < Piece
  attr_reader :move_pattern, :color, :name, :symbol
  attr_accessor :position, :moves, :board, :check_finder, :check

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
  end

  def to_s
    "#{@symbol}"
  end

  def to_symbol
    color == 'White' ? '♔' : '♚'
  end

  def to_fen
    color = 'White' ? 'K' : 'k'
  end

  def valid_moves
    @moves = []

    step_moves

    moves
  end

  def currently_in_check?
    check_finder.in_check?(self)
  end
end
