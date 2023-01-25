require "./lib/checkfinder"
require "./lib/board"

describe Checkfinder do
  subject(:check_finder) { described_class.new(board) }
  let(:board) { Board.new }
  
  describe "#in_check?" do
    it 'returns true if king is in check' do
      expect(check_finder.in_check?).to be true
    end

    it 'returns false if king is not in check' do
      expect(check_finder.in_check?).to be false
    end
  end
end

