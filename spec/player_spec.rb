require './lib/player'
require './lib/board'
require './lib/knight'

describe Player do
  describe "#pick_initial_piece" do
    context "a player selects a cell with a piece on it" do
      subject(:player_initial) { described_class.new('White') }
      let(:board_valid) { instance_double(Board) }

      before do
        player_color = player_initial.instance_variable_get(:@color)
        initial_piece = [0,1]
        knight = Knight.new('White', [0, 1])
        allow(player_initial).to receive(:select_cell).and_return(initial_piece)
        allow(board_valid).to receive(:select_player_piece).with(initial_piece, player_color).and_return(knight)
      end

      it "completes the loop and does not display the error message" do
        error_message = "That is not a valid piece. Please select a valid piece"
        expect(player_initial).not_to receive(:puts).with(error_message)
        player_initial.pick_initial_piece(board_valid)
      end
    end

    context "a player selects a cell without a piece on it once" do
      subject(:player_initial) { described_class.new('White') }
      let(:board_invalid) { instance_double(Board) }

      before do
        initial_piece = [1, 1]
        next_piece = [0, 1]
        player_color = player_initial.instance_variable_get(:@color)
        allow(player_initial).to receive(:select_cell).and_return(initial_piece, next_piece)
        knight = Knight.new('White', [0, 1])
        allow(board_invalid).to receive(:select_player_piece).with(initial_piece, player_color).and_return(nil)
        allow(board_invalid).to receive(:select_player_piece).with(next_piece, player_color).and_return(knight)
      end

      it "displays the error message once then completes the loop" do
        error_message = "That is not a valid piece. Please select a valid piece"
        expect(player_initial).to receive(:puts).with(error_message).once
        player_initial.pick_initial_piece(board_invalid)
      end
    end

    context "a player selects a cell with the other players piece on it once" do
      subject(:player_initial) { described_class.new('White') }
      let(:board_invalid) { instance_double(Board) }

      before do
        initial_piece = [0, 1]
        next_piece = [3, 3]
        allow(player_initial).to receive(:select_cell).and_return(initial_piece, next_piece)
        allow(board_invalid).to receive(:select_player_piece).and_return(false, true)
      end

      it "displays the error message once then completes the loop" do
        error_message = "That is not a valid piece. Please select a valid piece"
        expect(player_initial).to receive(:puts).with(error_message)
        player_initial.pick_initial_piece(board_invalid)
      end
    end
  end
    
  describe "#select_cell" do
    context "a player selects a valid cell" do
      subject(:player_select) { described_class.new('White') }

      before do
        user_input = 'B4'
        allow(player_select).to receive(:gets).and_return(user_input)
      end

      it "completes the loop and does not display the error message" do
        error_message = "Invalid Selection. Please select a valid cell"
        expect(player_select).not_to receive(:puts).with(error_message)
        player_select.select_cell
      end
    end

    context "a player selects an invalid cell once" do
      subject(:player_invalid) { described_class.new('White') }

      before do
        user_input_invalid = 'x7'
        user_input_valid = 'a7'
        allow(player_invalid).to receive(:gets).and_return(user_input_invalid, user_input_valid)
      end

      it "displays the error message once" do
        error_message = "Invalid Selection. Please select a valid cell"
        expect(player_invalid).to receive(:puts).with(error_message).once
        player_invalid.select_cell
      end
    end
  end

  describe "#valid_entry?" do
    subject(:player_entry) { described_class.new('White') }

    it "returns true if the selected cell is on the board" do
      user_input = 'A4'
      expect(player_entry.valid_entry?(user_input)).to be true
    end

    it "returns false if the selected cell is not on the board" do
      user_input = 'x1'
      expect(player_entry.valid_entry?(user_input)).to be false
    end
  end

  describe "#convert_entry" do
    subject(:player_convert) { described_class.new('White') }

    it "changes the user input to appropriate coordinates" do
      input = 'A4'
      converted_input = player_convert.convert_entry(input)
      expect(converted_input).to eq([0, 3])
    end
  end
end