# rewrite all moves into methods here, 
# and include Movement in each piece class

# create methods that check whether or not a move exposes a king
module Movement
  def move_right
    queue = [position]

    while queue
      current = queue.shift
      new_move = [current[0], current[1] + 1]
      queue << new_move

      next if current == position

      break if current[1] > 7 || board.players_piece?(current, color)

      moves << current if board.open_space?(current) || board.opponent_piece?(current, color)

      return if board.opponent_piece?(current, color)
    end
  end

  def move_left
    queue = [position]

    while queue
      current = queue.shift
      new_move = [current[0], current[1] - 1]
      queue << new_move

      next if current == position

      break if current[1] < 0 || board.players_piece?(current, color)

      moves << current if board.open_space?(current) || board.opponent_piece?(current, color)

      return if board.opponent_piece?(current, color)
    end
  end

  def move_up
    queue = [position]

    while queue
      current = queue.shift
      new_move = [current[0] + 1, current[1]]
      queue << new_move

      next if current == position

      break if current[0] > 7 || board.players_piece?(current, color)

      moves << current if board.open_space?(current) || board.opponent_piece?(current, color)
      return if board.opponent_piece?(current, color)
    end
  end

  def move_down
    queue = [position]

    while queue
      current = queue.shift
      new_move = [current[0] - 1, current[1]]
      queue << new_move

      next if current == position

      break if current[0].negative? || board.players_piece?(current, color)

      moves << current if board.open_space?(current) || board.opponent_piece?(current, color)
    
      return if board.opponent_piece?(current, color)
    end
  end

  def move_up_right
    queue = [position]

    while queue
      current = queue.shift
      new_move = [current[0] + 1, current[1] + 1]
      queue << new_move

      next if current == position

      break if current[1] > 7 || current[0] > 7 || board.players_piece?(current, color)

      moves << current if board.open_space?(current) || board.opponent_piece?(current, color)

      return if board.opponent_piece?(current, color)
    end
  end

  def move_up_left
    queue = [position]

    while queue
      current = queue.shift
      new_move = [current[0] + 1, current[1] - 1]
      queue << new_move

      next if current == position

      break if current[1] < 0 || current[0] > 7 || board.players_piece?(current, color)

      moves << current if board.open_space?(current) || board.opponent_piece?(current, color)
    
      return if board.opponent_piece?(current, color)
    end
  end

  def move_down_right
    queue = [position]

    while queue
      current = queue.shift
      new_move = [current[0] - 1, current[1] + 1]
      queue << new_move

      next if current == position

      break if current[1] > 7 || current[0] < 0 || board.players_piece?(current, color)

      moves << current if board.open_space?(current) || board.opponent_piece?(current, color)

      return if board.opponent_piece?(current, color)
    end
  end

  def move_down_left
    queue = [position]

    while queue
      current = queue.shift
      new_move = [current[0] - 1, current[1] - 1]
      queue << new_move

      next if current == position

      break if current[1].negative? || current[0].negative? || board.players_piece?(current, color)

      moves << current if board.open_space?(current) || board.opponent_piece?(current, color)

      return if board.opponent_piece?(current, color)
    end
  end

  def moves_expose_king?(move, current_position, color = @color)
    test_board = create_test_board
    test_king = find_king(color, test_board)

    test_move(move, current_position, test_board)
    return true if Checkfinder.new(test_board).in_check?(test_king)

    false
  end

  def test_move(test_move, current_position, test_board)
    test_piece = test_board.grid[current_position[0]][current_position[1]]
    test_board.move_piece(current_position)
    test_board.update_piece(test_move, test_piece)

    test_board.update_all_pieces
  end

  def create_test_board(board = @board)
    Marshal.load(Marshal.dump(board))
  end

  def find_king(color, board)
    board.grid.flatten.compact.each do |piece|
      next if piece.color != color

      return piece if piece.name == 'King'
    end
    false
  end
end