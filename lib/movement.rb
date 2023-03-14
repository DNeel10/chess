
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

  def step_moves
    potential_moves.each do |move|
      if board.open_space?(move)
        moves << move
      else
        moves << move unless board.players_piece?(move, color)
      end
    end
  end

  def king_step_moves
    potential_moves.each do |move|
      if board.open_space?(move)
        moves << move
      else
        moves << move unless board.players_piece?(move, color) || 
          Evaluation.new(@board, @color).moves_expose_king?(move, @position, @color)
      end
    end
  end

  def potential_moves(position = @position)
    move_pattern.map { |x, y| [position[0] + x, position[1] + y] }
                .select { |move| move.all? { |n| n >= 0 && n <= 7 } }
  end
end