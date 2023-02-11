require_relative 'board'

class Rook
  attr_reader :move_pattern, :color, :name, :board, :symbol
  attr_accessor :position, :moves

  # what needs to be set up when a piece is created in the game
  def initialize(position, color, board)
    @position = position
    @color = color
    @board = board
    @name = 'Rook'
    @symbol = to_fen
    @move_pattern = [[0, 1], [1, 0], [0, -1], [-1, 0]]
    @moves = []
  end

  def to_s
    "#{@symbol}"
  end

  def to_fen
    color == 'White' ? 'R' : 'r'
  end

  # rook can use move pattern in one (up, down, left, right) direction up to where another piece is
  # (capturing, or one before)
  def valid_moves(moves = @moves)
    @moves = []

    move_right
    move_left
    move_up
    move_down
    moves
  end

  def legal_move?(coordinates, moves = @moves)
    moves.include?(coordinates)
  end

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

      break if current[0] < 0 || board.players_piece?(current, color)

      moves << current if board.open_space?(current) || board.opponent_piece?(current, color) || current != position
    
      return if board.opponent_piece?(current, color)
    end
  end

  def update_position(coordinates)
    @position = coordinates
    @moves = []
    valid_moves
  end
end
