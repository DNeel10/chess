require './lib/knight'
require './lib/pawn'

describe Knight do
  describe '#potential_moves' do
    context 'an unmoved knight is selected by the player' do
      subject(:knight_moves) { described_class.new([0,1], 'Black') }

      it 'returns an array of all move options' do
        move_array = knight_moves.potential_moves
        expect(move_array).to eq([[1, 3], [2, 2], [2, 0]])
      end
    end

    context 'a knight in a subsequent position is selected by the player' do
      subject(:knight_subsequent) { described_class.new([4, 5], 'Black') }

      it 'returns an array of all move options' do
        move_array = knight_subsequent.potential_moves
        expect(move_array).to eq([[5, 7], [5, 3], [3, 7], [3, 3], [6, 6], [6, 4], [2, 6], [2, 4]])
      end
    end
  end

  describe '#valid_moves' do
    context 'a players potential moves may be limited by his own pieces' do
      subject(:knight_restricted) { described_class.new([0, 1], 'Black') }
      let(:player_piece) { instance_double(Pawn) }

      it 'removes moves where a players own piece is currently occupying' do
        board = Array.new(3) { Array.new(3, nil) }
        board[1][3] = Pawn.new([1, 3], 'Black')
        valid_list = knight_restricted.valid_moves(board)
        expect(valid_list).to eq([[2, 2], [2, 0]])
      end

      it 'does not remove a move where an enemy players piece is currently occupying' do
        board = Array.new(3) { Array.new(3, nil) }
        board[1][3] = Pawn.new([1, 3], 'White')
        valid_list = knight_restricted.valid_moves(board)
        expect(valid_list).to eq([[1, 3], [2, 2], [2, 0]])
      end
    end
  end
end
