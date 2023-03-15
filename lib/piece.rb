# Super class for all pieces
require_relative 'movement'
require_relative 'evaluation'

class Piece
  attr_accessor :position, :color, :board, :previous_position

  include Movement

  def initialize(position, color, board)
    @position = position
    @color = color
    @board = board
  end

  def valid_moves
    moves
  end

  def legal_moves
    @moves.reject! { |move| Evaluation.new(@board, @color).moves_expose_king?(move, position) }
  end

  def valid_selection?(coordinates, moves = @moves)
    moves.include?(coordinates)
  end

  def update_position(coordinates)
    @position = coordinates
    board.last_moved_piece = self
    @moves = []
  end
end