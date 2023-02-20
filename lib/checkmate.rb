class Checkmate
  attr_reader :board, :color

  def initialize(board, color)
    @board = board
    @color = color
  end
  
  def checkmate?
    no_moves_left? && king_in_check?
  end

  def no_moves_left?
    board.player_pieces(@color).all? { |piece| piece.moves.empty? }
  end

end
