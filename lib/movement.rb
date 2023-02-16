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

      moves << current if board.open_space?(current) || board.opponent_piece?(current, color) || current != position

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

      moves << current if board.open_space?(current) || board.opponent_piece?(current, color) || current != position
    
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

      moves << current if board.open_space?(current) || board.opponent_piece?(new_move, color)

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
end