class Player
  attr_reader :color, :selected_piece
  def initialize
    @color = color
    @selected_piece = []
  end

  def player_turn
  end

  def select_piece
    user_input = gets.chomp
    selected_piece << user_input
  end
end