require './lib/board'
require './lib/knight'
require './lib/player'
require './lib/pieces'

describe Board do
  describe "#select_player_piece" do
    subject(:board_piece) { described_class.new }
    let(:player_one) { Player.new('White', Pieces.new(board_piece), board_piece) }

    it "returns a piece when a valid cell is selected" do
      returned_piece = board_piece.select_player_piece([0, 1], player_one.color)
      expect(returned_piece).to_not be_nil
    end

    it "returns nil when a cell doesn't have a piece on it" do
      returned_piece = board_piece.select_player_piece([3, 3], player_one.color)
      expect(returned_piece).to be_nil
    end

    it "returns nil when a cell has the opponents piece on it" do
      returned_piece = board_piece.select_player_piece([7, 1], player_one.color)
      expect(returned_piece).to be_nil
    end
  end

  describe "#update_piece" do
    subject(:board_update) { described_class.new }

    it "adds a piece to the board at the given coordinate" do
      knight = Knight.new([0, 1], 'Black', board_update)
      coordinate = [0, 1]
      board_grid = board_update.instance_variable_get(:@grid)
      board_update.update_piece(coordinate, knight)
      updated_cell = board_grid[0][1]
      expect(updated_cell).to eq(knight)
    end
  end

end




