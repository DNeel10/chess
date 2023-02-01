class Checkfinder
  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def in_check?(board = @board, king)
    board.grid.each do |row|
      row.each do |piece|
        next if piece.nil? || piece == king || piece.color == king.color

        return true if piece.moves.include?(king.position)

        return false
      end
    end
  end
end