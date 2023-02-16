require './lib/king'
require './lib/pawn'
require './lib/knight'

describe King do
  describe '#valid_moves' do
    context 'a players potential moves may be limited' do
      let(:board) { Board.new }
      subject(:king_restricted) { described_class.new([0, 3], 'White', board) }

      it 'removes moves where a players own piece is currently occupying' do
        king_restricted.instance_variable_set(:@moves, [])
        board.grid[1][3] = Pawn.new([1, 3], 'White', board)
        king_restricted.valid_moves
        valid_list = king_restricted.instance_variable_get(:@moves)
        expect(valid_list).to match_array([[0, 2], [0, 4], [1, 2], [1, 4]])
      end

      it 'does not remove a move where an enemy players piece is currently occupying' do
        king_restricted.instance_variable_set(:@moves, [])
        board.grid[1][3] = Pawn.new([1, 3], 'Black', board)
        king_restricted.valid_moves
        valid_list = king_restricted.instance_variable_get(:@moves)
        expect(valid_list).to match_array([[1, 3], [1, 2], [1, 4]])
      end

      it 'removes a move where the king would be in check' do
        king_restricted.instance_variable_set(:@moves, [])
        knight = Knight.new([1, 4], 'Black', board)
        board.update_piece([1, 4], knight)
        king_restricted.valid_moves
        valid_list = king_restricted.instance_variable_get(:@moves)
        expect(valid_list).to match_array([[1, 3], [0, 4], [1, 2], [1, 4]])
      end
    end
  end
end
