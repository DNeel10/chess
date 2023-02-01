require_relative 'pawn'
require_relative 'queen'
require_relative 'king'
require_relative 'bishop'
require_relative 'rook'
require_relative 'knight'

class Pieces
  # factory for generating all pieces for white and black

  # each player needs:
  # 1 King, 1 Queen, 2 Rooks, 2 Knights, 2 Bishops, 8 Pawns

  def initialize(board)
    @board = board
  end


  def generate_pieces(player_color, board)
    pieces = []

    case player_color
    when 'White'
      8.times do |i|
        pieces << Pawn.new([1, i], player_color, board)
      end
      pieces << Rook.new([0, 0], player_color, board)
      pieces << Rook.new([0, 7], player_color, board)
      pieces << Knight.new([0, 1], player_color, board)
      pieces << Knight.new([0, 6], player_color, board)
      pieces << Bishop.new([0, 2], player_color, board)
      pieces << Bishop.new([0, 5], player_color, board)
      pieces << Queen.new([0, 3], player_color, board)
      pieces << King.new([0, 4], player_color, board)
    else
      8.times do |i|
        pieces << Pawn.new([6, i], player_color, board)
      end
      pieces << Rook.new([7, 0], player_color, board)
      pieces << Rook.new([7, 7], player_color, board)
      pieces << Knight.new([7, 1], player_color, board)
      pieces << Knight.new([7, 6], player_color, board)
      pieces << Bishop.new([7, 2], player_color, board)
      pieces << Bishop.new([7, 5], player_color, board)
      pieces << Queen.new([7, 3], player_color, board)
      pieces << King.new([7, 4], player_color, board)
    end
    pieces
  end

end
