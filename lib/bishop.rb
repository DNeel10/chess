class Bishop
  attr_reader :move_pattern, :color
  attr_accessor :position, :moves, :name, :board

  # what needs to be set up when a piece is created in the game
  def initialize(position, color, board)
    @position = position
    @color = color
    @board = board
    @name = 'Bishop'
    @move_pattern = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
    @moves = []
    valid_moves
  end

  def to_s
    "#{@name}, #{@position}"
  end

  def valid_moves
    move_up_right
    move_up_left
    move_down_right
    move_down_left
  end

  # bishop can move on a diagonal line any number of spaces (stopped by capturing a piece
  # or one before the players piece)
  def move_up_right
    queue = [position]

    while queue
      current = queue.shift

      return if current[1] >= 7 || current[0] >= 7 || board.players_piece?(current, color) || board.opponent_piece?(current, color)

      new_move = [current[0] + 1, current[1] + 1]
      queue << new_move
      moves << new_move if board.open_space?(new_move) || board.opponent_piece?(new_move, color)
    end
  end

  def move_up_left
    queue = [position]

    while queue
      current = queue.shift

      return if current[1] <= 0 || current[0] >= 7 ||board.players_piece?(current, color) || board.opponent_piece?(current, color)

      new_move = [current[0] + 1, current[1] - 1]
      queue << new_move
      moves << new_move if board.open_space?(new_move) || board.opponent_piece?(new_move, color)
    end
  end

  def move_down_right
    queue = [position]

    while queue
      current = queue.shift

      return if current[1] >= 7 || current[0] <= 0 || board.players_piece?(current, color) || board.opponent_piece?(current, color)

      new_move = [current[0] - 1, current[1] + 1]
      queue << new_move
      moves << new_move if board.open_space?(new_move) || board.opponent_piece?(new_move, color)
    end
  end

  def move_down_left
    queue = [position]

    while queue
      current = queue.shift

      return if current[1] <= 0 || current[0] <= 0 || board.players_piece?(current, color) || board.opponent_piece?(current, color)

      new_move = [current[0] - 1, current[1] - 1]
      queue << new_move
      moves << new_move if board.open_space?(new_move) || board.opponent_piece?(new_move, color)
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
