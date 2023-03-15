require_relative 'colorable_string'

class Board
  attr_accessor :grid, :last_moved_piece

  # using ColorableString

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    @last_moved_piece = nil
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
    player_piece if player_piece&.moves != []
  end

  def update_piece(coordinates, piece)
    return if piece.nil?
    rank, file = coordinates
    grid[rank][file] = piece
    piece.previous_position = piece.position
    piece.position = coordinates 
  end

  def set_piece(coordinates, piece)
    rank, file = coordinates
    grid[rank][file] = piece
    return if piece.nil?

    piece.position = coordinates
  end

  def update_all_pieces
    grid.flatten.compact.each(&:valid_moves)
  end

  def update_player_pieces(color)
    player_pieces(color).each { |piece| piece.valid_moves }
    player_pieces(color).each { |piece| piece.legal_moves }
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

  def player_pieces(color)
    player_pieces = []
    grid.flatten.compact.each do |piece|
      next if piece.color != color

      player_pieces << piece
    end
    player_pieces
  end
end
