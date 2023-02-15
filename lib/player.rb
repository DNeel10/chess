# frozen_string_literal: true

require_relative 'board'
require_relative 'pieces'
require_relative 'display'

class Player
  attr_reader :color
  attr_accessor :selected_piece, :player_pieces, :pieces, :board, :king

include Display
  def initialize(color, pieces, board)
    @color = color
    @board = board
    @player_pieces = pieces.generate_pieces(color, board)
    @selected_piece = nil
    @king = select_king
    @king_in_check = king.check

    build_board(board)
  end

  # TODO: Rework puts/display methods.  Included here for testing purposes
  def player_turn(board)
    display_board
    update_all_moves

    # select a piece to move
    puts 'Select a piece on the board'

    @selected_piece = pick_initial_piece(board)

    # display options of where the piece can go
    puts "#{selected_piece.name}'s current move options: #{convert_entry(selected_piece.moves)}"

    # move the selected piece
    puts 'Select where to move your piece'

    move_piece(board)
    board.update_all_pieces
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
    case input
    when String
      convert_to_coord(input)
    else
      convert_to_rank_file(input)
    end
  end

  def convert_to_coord(input)
    split_array = input.split('').map(&:ord)
    [split_array[1] - 49, split_array[0] - 65]
  end

  def convert_to_rank_file(input)
    converted_moves = []

    input.each do |coordinate|
      rank_file = [coordinate[1] + 65, coordinate[0] + 49]
      converted_moves << rank_file.map(&:chr).join
    end
    converted_moves
  end

  def select_piece_from_board(coordinates, board, color = @color)
    board.select_player_piece(coordinates, color)
  end

  def move_piece(board, piece = @selected_piece)
    loop do
      coordinates = select_cell

      return occupy_space(coordinates, board, piece) if legal_move_for_piece?(coordinates, piece) &&
                                                        board.open_space?(coordinates)
      return capture_piece(coordinates, board, piece) if legal_move_for_piece?(coordinates, piece) &&
                                                         board.opponent_piece?(coordinates, color)

      puts 'Ineligible move. Please choose a valid move'
    end
  end

  def update_all_moves(board = @board)
    board.update_all_pieces
  end

  def update_piece_on_board(coordinates, board, piece = @selected_piece)
    board.move_piece(piece.position)
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

  def legal_move_for_piece?(coordinates, piece = @selected_piece)
    piece.legal_move?(coordinates)
  end

  def select_king
    player_pieces.find { |piece| piece.name == 'King' }
  end
  
  # Does this fit in this class?
  def build_board(board)
    player_pieces.each do |piece|
      board.update_piece(piece.position, piece)
    end
  end
end
