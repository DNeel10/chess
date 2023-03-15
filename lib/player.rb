# frozen_string_literal: true

require_relative 'board'
require_relative 'pieces'
require_relative 'display'
require_relative 'checkmate'
require_relative 'checkfinder'

class Player
  attr_reader :color
  attr_accessor :selected_piece, :player_pieces, :pieces, :board, :king, :check_finder

  include Display

  def initialize(color, pieces, board)
    @color = color
    @board = board
    @player_pieces = pieces.generate_pieces(color, board)
    @selected_piece = nil
    @check_finder = Checkfinder.new(board)

    build_board(board)
  end

  # TODO: Rework puts/display methods.  Included here for testing purposes
  def player_turn(board = @board)
    puts "starting #{color} turn now"
    board.update_all_pieces
    display_board
    board.update_player_pieces(color)

    # select a piece to move
    puts 'Select a piece on the board or type [save] to save the game, or [quit] to quit' 

    @selected_piece = pick_initial_piece(board)
    return if @selected_piece == 'Save' || @selected_piece == 'Quit'
    # display options of where the piece can go
    puts "#{selected_piece.name}'s current move options: #{convert_entry(selected_piece.moves)}"

    # move the selected piece
    puts 'Select where to move your piece'

    move_piece(board)
    # board.update_all_pieces
  end

  def pick_initial_piece(board)
    loop do
      coordinates = select_cell
      return coordinates if coordinates == 'Save' || coordinates == 'Quit'

      return select_piece_from_board(coordinates, board) if select_piece_from_board(coordinates, board)

      puts 'That is not a valid piece. Please select a valid piece'
    end
  end

  # select_cell returns a coordinate on the board
  def select_cell
    loop do
      user_input = gets.capitalize.chomp
      return user_input if valid_entry?(user_input) && (user_input == 'Save' || user_input == 'Quit')
      return convert_entry(user_input) if valid_entry?(user_input)

      puts 'Invalid Selection. Please select a valid cell'
    end
  end

  # ensures the user is selecting a proper chess grid notation (ex. A4)
  def valid_entry?(input)
    input.match?(/[A-H][1-8]$|^Save$|^Quit$/)
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
      return castle_move(coordinates, board, piece) if legal_move_for_piece?(coordinates, piece) &&
                                                       cell_eligible_to_move?(coordinates)
      
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
    update_piece_on_board(coordinates, board)
    update_piece_position(coordinates)
  end

  def capture_piece(coordinates, board, piece = @selected_piece)
    board.remove_piece(coordinates)
    update_piece_on_board(coordinates, board)
    update_piece_position(coordinates)
  end

  def castle_move(coordinates, board, piece = @selected_piece)
    board.move_piece(piece.position)
    update_piece_position(coordinates)
  end

  def legal_move_for_piece?(coordinates, piece = @selected_piece)
    piece.valid_selection?(coordinates)
  end

  def cell_eligible_to_move?(coordinates)
    return true if board.open_space?(coordinates) || @selected_piece.is_a?(King) && board.grid[coordinates[0]][coordinates[1]].is_a?(Rook)
  end

  def select_king
    player_pieces.find { |piece| piece.name == 'King' }
  end

  # Does this fit in this class?
  def build_board(board)
    player_pieces.each do |piece|
      board.update_piece(piece.position, piece)
    end
    board.update_all_pieces
  end

  def checkmate?
    Checkmate.new(board, color, check_finder).checkmate?
  end

  def stalemate?
    Checkmate.new(board, color, check_finder).stalemate?
  end
end
