class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8, nil) }
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
    player_piece&.valid_moves
    player_piece if player_piece&.moves != []
  end

  def update_piece(coordinates, piece)
    rank, file = coordinates
    grid[rank][file] = piece
    piece.position = coordinates
    piece.valid_moves
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

  def display
    board = grid.flatten.map { |val| val.nil? ? ' ' : val }

    puts ''
    puts '     A     B     C     D     E     F     G     H   '
    puts divider
    puts "8 |  #{board[56]}  |  #{board[57]}  |  #{board[58]}  |  #{board[59]}  |  #{board[60]}  |  #{board[61]}  |  #{board[62]}  |  #{board[63]}  |"
    puts divider
    puts "7 |  #{board[48]}  |  #{board[49]}  |  #{board[50]}  |  #{board[51]}  |  #{board[52]}  |  #{board[53]}  |  #{board[54]}  |  #{board[55]}  |"
    puts divider
    puts "6 |  #{board[40]}  |  #{board[41]}  |  #{board[42]}  |  #{board[43]}  |  #{board[44]}  |  #{board[45]}  |  #{board[46]}  |  #{board[47]}  |"
    puts divider
    puts "5 |  #{board[32]}  |  #{board[33]}  |  #{board[34]}  |  #{board[35]}  |  #{board[36]}  |  #{board[37]}  |  #{board[38]}  |  #{board[39]}  |"
    puts divider
    puts "4 |  #{board[24]}  |  #{board[25]}  |  #{board[26]}  |  #{board[27]}  |  #{board[28]}  |  #{board[29]}  |  #{board[30]}  |  #{board[31]}  |"
    puts divider
    puts "3 |  #{board[16]}  |  #{board[17]}  |  #{board[18]}  |  #{board[19]}  |  #{board[20]}  |  #{board[21]}  |  #{board[22]}  |  #{board[23]}  |"
    puts divider
    puts "2 |  #{board[8]}  |  #{board[9]}  |  #{board[10]}  |  #{board[11]}  |  #{board[12]}  |  #{board[13]}  |  #{board[14]}  |  #{board[15]}  |"
    puts divider
    puts "1 |  #{board[0]}  |  #{board[1]}  |  #{board[2]}  |  #{board[3]}  |  #{board[4]}  |  #{board[5]}  |  #{board[6]}  |  #{board[7]}  |"
    puts divider
    puts '     A     B     C     D     E     F     G     H   '
    puts ''
  end

  def divider
    '  |-----+-----+-----+-----+-----+-----+-----+-----|'
  end
end
