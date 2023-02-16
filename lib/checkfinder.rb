class Checkfinder
  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def in_check?(king, board = @board)
    board.grid.flatten.compact.each do |piece|
      next if piece.color == king.color

      return true if piece.valid_moves.include?(king.position)
    end
    false
  end

  def would_be_in_check?(king, move, board = @board)
    board.grid.flatten.compact.each do |piece|
      next if piece.color == king.color

      return true if piece.valid_moves.include?(move)
    end
    false
  end
end
