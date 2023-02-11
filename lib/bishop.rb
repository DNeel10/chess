class Bishop
  attr_reader :move_pattern, :color
  attr_accessor :position, :moves, :name, :board

  # what needs to be set up when a piece is created in the game
  def initialize(position, color, board)
    @position = position
    @color = color
    @board = board
    @name = 'Bishop'
    @symbol = to_fen
    @move_pattern = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
    @moves = []
  end

  def to_s
    "#{@symbol}"
  end

  def to_fen
    color == 'White' ? 'B' : 'b'
  end

  def valid_moves(moves = @moves)
    @moves = []

    move_up_right
    move_up_left
    move_down_right
    move_down_left
    moves
  end

  # bishop can move on a diagonal line any number of spaces (stopped by capturing a piece
  # or one before the players piece)
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

      break if current[1].negative? || current[0] > 7 || board.players_piece?(current, color)

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

      break if current[1] > 7 || current[0].negative? || board.players_piece?(current, color)

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

  def legal_move?(coordinates, moves = @moves)
    moves.include?(coordinates)
  end

  def update_position(coordinates)
    @position = coordinates
    @moves = []
    valid_moves
  end
end
