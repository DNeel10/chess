# frozen_string_literal: true
require_relative 'board'
require_relative 'player'
require_relative 'pieces'

# controls the flow of the game
class Game
  attr_accessor :player1, :player2, :board
  def initialize(player1, player2, board)
    @player1 = player1
    @player2 = player2
    @board = board
  end

  def play_game
    loop do
      player1.player_turn(board)
      player2.player_turn(board)
    end
  end
end

board = Board.new
player1 = Player.new('White', Pieces.new(board), board)
player2 = Player.new('Black', Pieces.new(board), board)

Game.new(player1, player2, board).play_game
