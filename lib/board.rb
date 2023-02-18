require_relative 'colorable_string'

class Board
  attr_accessor :grid

  # using ColorableString

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def players_piece?(coordinates, player_color)
    rank, file = coordinates
    grid[rank][file] && grid[rank][file].color == player_color
  end

  def opponent_piece?(coordinates, player_color)
    rank, file = coordinates
    grid[rank][file] && grid[rank][file].color != player_color
  end

  def select_player_piece(coordinates, player_color)
    rank, file = coordinates
    player_piece = grid[rank][file] if players_piece?(coordinates, player_color)
    player_piece if player_piece&.valid_moves != []
  end

  def update_piece(coordinates, piece)
    rank, file = coordinates
    grid[rank][file] = piece
    return if piece.nil?
    
    piece.position = coordinates
    piece.valid_moves
  end

  def update_all_pieces
    grid.flatten.compact.each(&:valid_moves)
  end

  def open_space?(coordinates)
    rank, file = coordinates
    grid[rank][file].nil?
  end

  def remove_piece(coordinates)
    rank, file = coordinates
    grid[rank][file].position = nil
    grid[rank][file] = nil
  end

  def move_piece(coordinates)
    rank, file = coordinates
    grid[rank][file] = nil
  end
end
