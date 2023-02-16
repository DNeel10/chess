class Checkmate

  def initialize(board)
    @board = board
  end
  
  def checkmate?
    if king.moves.empty?
      return true if blocking_moves.empty?

    end
    false
  end

  def blocking_moves(king)
    move_list = []

    move_list
  
    # opponent piece coordinates Ox, Oy
    # king position Coordinates Kx, Ky
    # All player pieces check for moves that are between (Oy, Py) and (Ox, Px)
  
  end

  def opponent_piece(king)
    board.grid.flatten.compact.each do |piece|
      next if piece.color == king.color

      piece
    end
  end
end