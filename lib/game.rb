# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'pieces'
require_relative 'display'

# controls the flow of the game
class Game
  attr_accessor :player1, :player2, :board, :current_player

  def initialize(player1, player2, board)
    @player1 = player1
    @player2 = player2
    @board = board
    @current_player = player1
  end

  def play_game
    play_round
    game_ending
  end

  def play_round
    until game_over?
      current_player.player_turn
      @current_player = opponent
    end
  end

  def game_over?
    return "Checkmate! #{current_player.color.capitalize} player wins!" if opponent.checkmate? 
    return 'Stalemate! No winner!' if opponent.stalemate?
  end

  def opponent
    current_player == player1 ? player2 : player1
  end

  def game_ending
    puts game_over?
  end
end

board = Board.new
player1 = Player.new('White', Pieces.new(board), board)
player2 = Player.new('Black', Pieces.new(board), board)

Game.new(player1, player2, board).play_game
