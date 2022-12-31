require './lib/player'

describe Player do
  
  describe "#select_cell" do

    context "a player selects a valid cell" do
      subject(:player_select) { described_class.new }
      
      before do
        user_input = 'a4'
        allow(player_select).to receive(:gets).and_return(user_input)
        allow(player_select).to receive(:valid_entry?).and_return(true)
      end

      it "completes the loop and does not display the error message" do
        selected_cell = player_select.instance_variable_get(:@selected_cell)
        player_select.select_cell
        expect(player_select.selected_cell).to eq('a4')
      end
    end

    context "a player selects an invalid cell once" do
      subject(:player_invalid) { described_class.new }

      before do
        user_input = 'x12'
        allow(player_invalid).to receive(:gets).and_return(user_input)
        allow(player_invalid).to receive(:valid_entry?).and_return(false, true)
      end

      it "displays the error message once" do
        error_message = "Invalid Selection. Please select a valid cell"
        selected_cell = player_invalid.instance_variable_get(:@selected_cell)
        expect(player_invalid).to receive(:puts).with(error_message).once
        player_invalid.select_cell
      end
    end
  end

  describe "#valid_entry?" do
    subject(:player_valid) { described_class.new }

    it "returns true if the selected cell is on the board" do
      user_input = 'a4'
      expect(player_valid.valid_entry?(user_input)).to be true
    end
  end

end