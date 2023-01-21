
require_relative 'knight'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8, nil) }
  end

  def players_piece?(coordinates, player_color)
    @grid[coordinates[0]][coordinates[1]] && @grid[coordinates[0]][coordinates[1]].color == player_color
  end

  def opponent_piece?(coordinates, player_color)
    @grid[coordinates[0]][coordinates[1]] && @grid[coordinates[0]][coordinates[1]].color != player_color
  end

  def select_player_piece(coordinates, player_color)
    player_piece = @grid[coordinates[0]][coordinates[1]]
    return player_piece if players_piece?(coordinates, player_color)
  end

  def update_piece(coordinates, piece)
    @grid[coordinates[0]][coordinates[1]] = piece
  end

  def open_space?(coordinates)
    @grid[coordinates[0]][coordinates[1]].nil?
  end

  def remove_piece(coordinates)
    @grid[coordinates[0]][coordinates[1]].position = nil
    @grid[coordinates[0]][coordinates[1]] = nil
  end

  def display(grid = @grid)
    puts
    grid.reverse.each do |row|
      puts row.join
    end
  end
end
