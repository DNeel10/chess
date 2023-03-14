# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'pieces'
require_relative 'display'
require_relative 'serialize'
require 'yaml'

# controls the flow of the game
class Game
  attr_accessor :player1, :player2, :board, :current_player

  include Serialize

  def initialize(player1, player2, board)
    @player1 = player1
    @player2 = player2
    @board = board
    @current_player = player1
  end

  def play
    game_mode
  end

  def play_game
    play_round
    game_ending
  end

  def play_round
    until game_over?
      current_player.player_turn
      return save_game if current_player.selected_piece == 'Save'
      return exit if current_player.selected_piece == 'Quit'
      @current_player = opponent
      board.update_player_pieces(@current_player.color)
      board.update_player_pieces(opponent.color)
    end
  end

  def game_mode
    puts "Select a game mode:\n Type [1] for New Game\n Type [2] to Load a saved game"
    mode = gets.chomp
    play_game if mode == '1'
    load_game if mode == '2'
  end

  def game_over?
    return "Checkmate! #{opponent.color.capitalize} player wins!" if current_player.checkmate? 
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

Game.new(player1, player2, board).play
