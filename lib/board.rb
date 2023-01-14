
require_relative 'knight'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8, nil) }
  end

  def players_piece?(coordinates, player_color)
    @grid[coordinates[0]][coordinates[1]] && @grid[coordinates[0]][coordinates[1]].color == player_color
  end

  def select_player_piece(coordinates, player_color)
    player_piece = @grid[coordinates[0]][coordinates[1]]
    return player_piece if players_piece?(coordinates, player_color)
  end

  def update_piece(coordinate, piece)
    @grid[coordinate[0]][coordinate[1]] = piece
  end
end
