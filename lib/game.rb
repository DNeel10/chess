# frozen_string_literal: true

# controls the flow of the game
class Game

  def initialize
    @players = []
    @board = Board.new
    @pieces = Pieces.new
  end 

end