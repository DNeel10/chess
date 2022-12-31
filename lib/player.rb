# frozen_string_literal: true

require_relative 'board'

class Player
  attr_reader :color
  attr_accessor :selected_cell

  def initialize
    @color = color
    @selected_cell = nil
    @available_pieces = []
  end

  def player_turn
    # player selects a cell
    select_cell

    # selected cell gets passed to board to verify the selection (make sure a players 
    # piece is on it or its a valid move location

    # piece displays valid move options

    # player selects a cell to move the piece to

  end

  # reuse this for any time you need to select a cell (picking a piece, or selecting
  # the new space)
  def select_cell
    loop do
      user_input = gets.chomp
      return convert_entry(user_input) if valid_entry?(user_input)

      puts "Invalid Selection. Please select a valid cell"
    end
  end

  def valid_entry?(input)
    input.match?(/[a-hA-H][1-8]/)
  end

  def convert_entry(input)
    split_array = input.split('').map(&:ord)
    converted_array = [split_array[0] - 65, split_array[1] - 49 ]
  end
end