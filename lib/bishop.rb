class Bishop
  attr_reader :move_pattern, :color
  attr_accessor :position, :moves

  # what needs to be set up when a piece is created in the game
  def initialize(position, color)
    @position = position
    @color = color
    @move_pattern = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
    @moves = []
  end

  def valid_moves(board)
    move_up_right(board)
    move_up_left(board)
    move_down_right(board)
    move_down_left(board)
  end

  # bishop can move on a diagonal line any number of spaces (stopped by capturing a piece
  # or one before the players piece)
  def move_up_right(board, moves = @moves, position = @position)
    queue = [position]

    while queue
      current = queue.shift

      return if current[1] >= 7 || current[0] >= 7 || board.players_piece?(current, color)

      new_move = [current[0] + 1, current[1] + 1]
      queue << new_move
      moves << new_move if board.open_space?(new_move) || board.opponent_piece?(new_move)
    end
  end

  def move_up_left(board, moves = @moves, position = @position)
    queue = [position]

    while queue
      current = queue.shift

      return if current[1] <= 0 || current[0] >= 7 ||board.players_piece?(current, color)

      new_move = [current[0] + 1, current[1] - 1]
      queue << new_move
      moves << new_move if board.open_space?(new_move) || board.opponent_piece?(new_move)
    end
  end

  def move_down_right(board, moves = @moves, position = @position)
    queue = [position]

    while queue
      current = queue.shift

      return if current[1] >= 7 || current[0] <= 0||board.players_piece?(current, color)

      new_move = [current[0] - 1, current[1] + 1]
      queue << new_move
      moves << new_move if board.open_space?(new_move) || board.opponent_piece?(new_move)
    end
  end

  def move_down_left(board, moves = @moves, position = @position)
    queue = [position]

    while queue
      current = queue.shift

      return if current[1] <= 0 || current[0] <= 0 || board.players_piece?(current, color)

      new_move = [current[0] - 1, current[1] - 1]
      queue << new_move
      moves << new_move if board.open_space?(new_move) || board.opponent_piece?(new_move)
    end
  end

  def legal_move?(coordinates, moves = @moves)
    moves.include?(coordinates)
  end

end
