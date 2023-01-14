# frozen_string_literal: true

require_relative 'board'
require_relative 'knight'

class Player
  attr_reader :color
  attr_accessor :selected_piece

  def initialize(color)
    @color = color
    @active_pieces = []
    @selected_piece = nil
  end

  def player_turn(board)
    # select a piece to move
    puts 'Select a piece on the board'

    @selected_piece = pick_initial_piece(board)

    # display options of where the piece can go

    # move the selected piece
    puts 'Select where to move your piece'

    move_piece(board)
  end

  def pick_initial_piece(board)
    loop do
      coordinates = select_cell
      return select_piece_from_board(coordinates, board) if select_piece_from_board(coordinates, board)

      puts 'That is not a valid piece. Please select a valid piece'
    end
  end

  # select_cell returns a coordinate on the board
  def select_cell
    loop do
      user_input = gets.capitalize.chomp
      return convert_entry(user_input) if valid_entry?(user_input)

      puts 'Invalid Selection. Please select a valid cell'
    end
  end

  # ensures the user is selecting a proper chess grid notation (ex. A4)
  def valid_entry?(input)
    input.match?(/[A-H][1-8]/)
  end

  # returns an array with coordinates
  def convert_entry(input)
    split_array = input.split('').map(&:ord)
    [split_array[0] - 65, split_array[1] - 49]
  end

  def select_piece_from_board(coordinates, board, color = @color)
    board.select_player_piece(coordinates, color)
  end

  def move_piece(board, piece = @selected_piece)
    coordinate = select_cell
    update_piece_on_board(coordinate, board, piece)
    update_piece_position(coordinate)
  end

  def update_piece_on_board(coordinate, board, piece)
    board.update_piece(coordinate, piece)
  end

  def update_piece_position(coordinate, piece)
    piece.position = coordinate
  end
end
