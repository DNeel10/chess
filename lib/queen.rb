class Queen
  attr_reader :move_pattern, :color, :name
  attr_accessor :position, :moves

  # what needs to be set up when a piece is created in the game
  def initialize(position, color, board)
    @position = position
    @color = color
    @name = 'Queen'
    @move_pattern = [[0, 1], [1, 0], [0, -1], [-1, 0],
                     [1, 1], [1, -1], [-1, 1], [-1, -1]]
    @moves = []
    # valid_moves(board)
  end

  def to_s
    "#{@name}, #{@position}"
  end

  def valid_moves(board)
    move_right(board)
    move_left(board)
    move_up(board)
    move_down(board)
    move_up_right(board)
    move_up_left(board)
    move_down_right(board)
    move_down_left(board)
  end

  def legal_move?(coordinates, moves = @moves)
    moves.include?(coordinates)
  end

  def move_right(board, moves = @moves, position = @position)
    queue = [position]

    while queue
      current = queue.shift

      return if current[1] >= 7 || board.players_piece?(current, color) || board.opponent_piece?(current, color)

      new_move = [current[0], current[1] + 1]
      queue << new_move
      moves << new_move if board.open_space?(new_move) || board.opponent_piece?(new_move, color)
    end
  end

  def move_left(board, moves = @moves, position = @position)
    queue = [position]

    while queue
      current = queue.shift

      return if current[1] <= 0 || board.players_piece?(current, color) || board.opponent_piece?(current, color)

      new_move = [current[0], current[1] - 1]
      queue << new_move
      moves << new_move if board.open_space?(new_move) || board.opponent_piece?(new_move, color)
    end
  end

  def move_up(board, moves = @moves, position = @position)
    queue = [position]

    while queue
      current = queue.shift

      return if current[0] >= 7 || board.players_piece?(current, color) || board.opponent_piece?(current, color)

      new_move = [current[0] + 1, current[1]]
      queue << new_move
      moves << new_move if board.open_space?(new_move) || board.opponent_piece?(new_move, color)
    end
  end

  def move_up_right(board, moves = @moves, position = @position)
    queue = [position]

    while queue
      current = queue.shift

      return if current[1] >= 7 || current[0] >= 7 || board.players_piece?(current, color) || board.opponent_piece?(current, color)

      new_move = [current[0] + 1, current[1] + 1]
      queue << new_move
      moves << new_move if board.open_space?(new_move) || board.opponent_piece?(new_move, color)
    end
  end

  def move_up_left(board, moves = @moves, position = @position)
    queue = [position]

    while queue
      current = queue.shift

      return if current[1] <= 0 || current[0] >= 7 ||board.players_piece?(current, color) || board.opponent_piece?(current, color)

      new_move = [current[0] + 1, current[1] - 1]
      queue << new_move
      moves << new_move if board.open_space?(new_move) || board.opponent_piece?(new_move, color)
    end
  end

  def move_down_right(board, moves = @moves, position = @position)
    queue = [position]

    while queue
      current = queue.shift

      return if current[1] >= 7 || current[0] <= 0 || board.players_piece?(current, color) || board.opponent_piece?(current, color)

      new_move = [current[0] - 1, current[1] + 1]
      queue << new_move
      moves << new_move if board.open_space?(new_move) || board.opponent_piece?(new_move, color)
    end
  end

  def move_down_left(board, moves = @moves, position = @position)
    queue = [position]

    while queue
      current = queue.shift

      return if current[1] <= 0 || current[0] <= 0 || board.players_piece?(current, color) || board.opponent_piece?(current, color)

      new_move = [current[0] - 1, current[1] - 1]
      queue << new_move
      moves << new_move if board.open_space?(new_move) || board.opponent_piece?(new_move, color)
    end
  end

  def move_down(board, moves = @moves, position = @position)
    queue = [position]

    while queue
      current = queue.shift

      return if current[0] <= 0 || board.players_piece?(current, color) || board.opponent_piece?(current, color)

      new_move = [current[0] - 1, current[1]]
      queue << new_move
      moves << new_move if board.open_space?(new_move) || board.opponent_piece?(new_move, color)
    end
  end

  def update_position(coordinates)
    @position = coordinates
    @moves = []
    valid_moves(board)
  end
end
