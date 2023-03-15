require './lib/board'
require './lib/knight'
require './lib/player'
require './lib/pieces'
require './lib/rook'
require './lib/king'
require './lib/pawn'

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

  describe '#move_piece' do 
    subject(:board_update) { described_class.new }
    
    it 'changes a cell to nil when a piece moves from it' do
      knight = Knight.new([0, 1], 'Black', board_update)
      coordinate = knight.position
      board_grid = board_update.instance_variable_get(:@grid)
      board_grid[0][1] = knight
      board_update.move_piece(coordinate)
      expect(board_grid[0][1]).to be_nil
    end
  end

  describe '#player_pieces' do
    subject(:board_select) { described_class.new }

    before do
      white_knight = Knight.new([0, 1], 'White', board_select)
      board_select.update_piece([0, 1], white_knight)
      white_king = King.new([0, 3], 'White', board_select)
      board_select.update_piece([0, 3], white_king)
      white_rook = Rook.new([0, 0], 'White', board_select)
      board_select.update_piece([0, 0], white_rook)
      black_rook = Rook.new([7, 0], 'Black', board_select)
      board_select.update_piece([7, 0], black_rook)
    end

    it 'returns an array of the proper length' do
      white_piece_array = board_select.player_pieces('White')
      expect(white_piece_array.length).to eq(3)
    end

    it 'the returned array contains only pieces with color "White"' do
      white_piece_array = board_select.player_pieces('White')
      only_white_pieces = white_piece_array.all? { |piece| piece.color == 'White' }
      expect(only_white_pieces).to be true
    end
  end

  describe 'last_moved' do
    subject(:board_last) { described_class.new }
    let(:white_pawn) { Pawn.new([1, 0], 'White', board_last) }
    let(:black_pawn) { Pawn.new([6, 0], 'Black', board_last) }

    before do
      board_last.update_piece([1, 0], white_pawn)
      board_last.update_piece([6, 0], black_pawn)
    end

    it 'returns the pawn that moved last' do
      white_pawn.update_position([3, 0])
      expect(board_last.last_moved_piece).to eq(white_pawn)
    end

    it 'updates @last_moved_pawn once another pawn moves' do
      white_pawn.update_position([3, 0])
      black_pawn.update_position([4, 0])
      expect(board_last.last_moved_piece).to eq(black_pawn)
    end
  end
end




