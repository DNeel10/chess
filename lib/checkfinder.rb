class Checkfinder
  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def in_check?(king, board = @board)
    board.grid.each do |row|
      row.each do |piece|
        next if piece.nil? || piece == king || piece.color == king.color

        return true if piece.moves.include?(king.position)
      end
    end
    false
  end

  def would_be_in_check?(king, move, board = @board)
    board.grid.each do |row|
      row.each do |piece|
        next if piece.nil? || piece == king || piece.color == king.color
        # puts "#{piece.name}'s moves: #{piece.moves}" if piece.moves.include?(move)
        return true if piece.moves.include?(move)

      end

    end
    false
  end
end