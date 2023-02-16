class Checkmate

  def initialize(board)
    @board = board
  end
  
  def checkmate?
    king.moves.empty? && blocking_moves.empty?
  end

  def blocking_moves(king)


    # opponent piece coordinates Ox, Oy
    # king position Coordinates Kx, Ky
    # All player pieces check for moves that are between (Oy, Py) and (Ox, Px)
  end
end
