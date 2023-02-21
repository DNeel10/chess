class Checkmate
  attr_reader :board, :color, :check_finder

  def initialize(board, color, check_finder)
    @board = board
    @color = color
    @check_finder = check_finder
  end
  
  def checkmate?
    no_moves_left? && king_in_check?
  end

  def no_moves_left?
    board.player_pieces(@color).all? { |piece| piece.moves.empty? }
  end

  def king_in_check?
    king = check_finder.find_king(@color)

    check_finder.in_check?(king)
  end

  def stalemate?
    no_moves_left? && !king_in_check?
  end
end
