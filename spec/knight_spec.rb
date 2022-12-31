require './lib/knight'

describe Knight do
  describe "#find_moves" do
    context "an unmoved knight is selected by the player" do
      subject(:knight_moves) { described_class.new([0,1], 'Black') }

      it "returns an array of all move options" do
        move_array = knight_moves.find_moves
        expect(move_array).to eq([[1, 3], [2, 2], [2, 0]])
      end
    end

    context "a knight in a subsequent position is selected by the player" do
      subject(:knight_subsequent) { described_class.new([4, 5], 'Black') }

      it "returns an array of all move options" do
        move_array = knight_subsequent.find_moves
        expect(move_array).to eq([[5, 7], [5, 3], [3, 7], [3, 3], [6, 6], [6, 4], [2, 6], [2, 4]])
      end
    end
  end
end
