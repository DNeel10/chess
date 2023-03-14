module Display
  using ColorableString

  def display_board(board = @board)
    puts

    game_board = board.grid.reverse
    puts '   A  B  C  D  E  F  G  H '
    game_board.each_with_index do |rank, i|

      puts "#{8 - i} " + draw_cell(rank, i) + " #{8 - i}"

    end
    puts '   A  B  C  D  E  F  G  H '
    puts
  end

  def draw_cell(rank, r_idx)
    rank.map.with_index do |cell, c_idx|
      piece_display(cell).background_color(r_idx, c_idx)
    end.join
  end

  def piece_display(piece)
    piece.nil? ? '   ' : ' ' + piece.symbol + ' '
  end
end