class Evaluation

  def initialize(board, color)
    @board = board
    @color = color
  end

  def moves_expose_king?(move, current_position, color = @color)
    test_board = create_test_board
    test_king = find_king(color, test_board)

    test_move(move, current_position, test_board)
    test_board.update_all_pieces
    return true if Checkfinder.new(test_board).in_check?(test_king)

    false
  end

  def test_move(test_move, current_position, test_board)
    test_piece = test_board.grid[current_position[0]][current_position[1]]
    test_board.move_piece(current_position)
    test_board.update_piece(test_move, test_piece)
  end

  def create_test_board(board = @board)
    Marshal.load(Marshal.dump(board))
  end

  def find_king(color, board)
    board.grid.flatten.compact.each do |piece|
      next if piece.color != color

      return piece if piece.is_a?(King)
    end
  end
end