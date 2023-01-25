class Checkfinder
  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def in_check?(board = @board)
    true
  end

end