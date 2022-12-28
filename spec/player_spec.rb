require './lib/player'

describe Player do
  
  describe "#select_piece" do

    context "it is now a new player's turn to play" do
      subject(:player_select) { described_class.new }
      
      before do
        user_input = 'a4'
        allow(player_select).to receive(:gets).and_return(user_input)
      end

      it "moves the selected piece into the selected piece array" do
        user_input = 'a4'
        selected_piece = player_select.instance_variable_get(:@selected_piece)
        player_select.select_piece
        expect(player_select.selected_piece).to include('a4')
      end
    end
  end

end