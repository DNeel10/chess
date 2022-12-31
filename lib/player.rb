# frozen_string_literal: true

require_relative 'board'

class Player
  attr_reader :color
  attr_accessor :selected_cell

  def initialize
    @color = color
    @selected_cell = nil
  end

  def player_turn
    # select a cell on the board with a piece on it
    select_cell
    # select cell to move the piece to

  end

  # reuse this for any time you need to select a cell (picking a piece, or selecting
  # the new space)
  def select_cell
    loop do
      user_input = gets.chomp
      return user_input if valid_entry?(user_input)

      puts "Invalid Selection. Please select a valid cell"
    end
  end

  def valid_entry?(input)
    input.match?(/[a-hA-H][1-8]/)
  end
end