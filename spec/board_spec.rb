require './lib/board'
require './lib/knight'

describe Board do
  describe "#find_piece" do
    subject(:board_piece) { described_class.new }

    it "returns a piece when a valid cell is selected" do
      knight = Knight.new([0,1], 'White')
      board_piece.grid[0][1] = knight
      returned_piece = board_piece.find_piece([0,1])
      expect(returned_piece).to eq(knight)
    end

    it "returns nil when a cell doesn't have a piece on it" do
      knight = Knight.new([0,1], 'White')
      board_piece.grid[0][1] = knight
      returned_piece = board_piece.find_piece([1,3])
      expect(returned_piece).to be_nil
    end
  end
end




