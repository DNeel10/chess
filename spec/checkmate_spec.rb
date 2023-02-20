describe Checkmate do

  describe '#no_moves_left?' do
    context 'none of the white pieces can make a legal move' do
      let(:board) { Board.new } 
      subject(:white_checkmate) { described_class.new(board)}

      it 'returns true when the available white pieces all have empty move arrays' do
      end
    end
  end
  # TODO: Finish this test 
end
