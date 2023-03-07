# Super class for all pieces
require_relative 'movement'
require_relative 'evaluation'

class Piece
  attr_accessor :position, :color, :board

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
    @moves = []
  end
end