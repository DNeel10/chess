# frozen_string_literal: true

require_relative 'board'
require_relative 'pieces'

class Player
  attr_reader :color
  attr_accessor :selected_piece, :active_pieces, :pieces, :board

  def initialize(color, pieces, board = Board.new)
    @color = color
    @active_pieces = pieces.generate_pieces(color)
    @selected_piece = nil
    @king_in_check = false
    @board = board
    set_up_board(board)
  end

  def player_turn(board)
    # select a piece to move
    puts 'Select a piece on the board'

    @selected_piece = pick_initial_piece(board)

    # display options of where the piece can go
    # selected_piece.display_valid_moves

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
    loop do
      coordinates = select_cell
      return occupy_space(coordinates, board, piece) if legal_move_for_piece?(coordinates, board, piece) &&
                                                        board.open_space?
      return capture_piece(coordinates, board, piece) if legal_move_for_piece?(coordinates, board, piece) &&
                                                         board.opponent_piece?

      puts 'Ineligible move. Please choose a valid move'
    end
  end

  def update_piece_on_board(coordinates, board, piece = @selected_piece)
    board.update_piece(coordinates, piece)
  end

  def update_piece_position(coordinates, piece = @selected_piece)
    piece.update_position(coordinates)
  end

  def occupy_space(coordinates, board, piece = @selected_piece)
    update_piece_on_board(coordinates, board, piece)
    update_piece_position(coordinates)
  end

  def capture_piece(coordinates, board, piece = @selected_piece)
    board.remove_piece(coordinates)
    update_piece_on_board(coordinates, board)
    update_piece_position(coordinates, piece)
  end

  def legal_move_for_piece?(coordinates, board, piece = @selected_piece)
    piece.legal_move?(board, coordinates)
  end

  def set_up_board(board)
    @active_pieces.each do |piece|
      board.update_piece(piece.position, piece)
    end
  end
end
