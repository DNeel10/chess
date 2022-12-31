require './lib/player'

describe Player do
  
  describe "#select_cell" do

    context "a player selects a valid cell" do
      subject(:player_select) { described_class.new }
      
      before do
        user_input = 'x4'
        allow(player_select).to receive(:gets).and_return(user_input)
        allow(player_select).to receive(:valid_entry?).and_return(true)
      end

      it "completes the loop and does not display the error message" do
        error_message = "Invalid Selection. Please select a valid cell"
        expect(player_select).not_to receive(:puts).with(error_message)
        player_select.select_cell
      end
    end

    context "a player selects an invalid cell once" do
      subject(:player_invalid) { described_class.new }

      before do
        user_input = 'a7'
        allow(player_invalid).to receive(:gets).and_return(user_input)
        allow(player_invalid).to receive(:valid_entry?).and_return(false, true)
      end

      it "displays the error message once" do
        error_message = "Invalid Selection. Please select a valid cell"
        expect(player_invalid).to receive(:puts).with(error_message).once
        player_invalid.select_cell
      end
    end
  end

  describe "#valid_entry?" do
    subject(:player_entry) { described_class.new }

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
    subject(:player_convert) { described_class.new }

    it "changes the user input to appropriate coordinates" do
      input = 'A4'
      converted_input = player_convert.convert_entry(input)
      expect(converted_input).to eq([0, 3])
    end
  end
end