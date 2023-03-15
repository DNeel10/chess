require './lib/king'
require './lib/pawn'
require './lib/knight'
require './lib/rook'

describe King do
  describe '#valid_moves' do
    context 'a players potential moves may be limited' do
      let(:board) { Board.new }
      subject(:king_restricted) { described_class.new([0, 4], 'White', board) }

      it 'removes moves where a players own piece is currently occupying' do
        board.update_piece([0, 4], king_restricted)
        king_restricted.instance_variable_set(:@moves, [])
        white_pawn = Pawn.new([1, 4], 'White', board)
        board.update_piece([1, 4], white_pawn)
        king_restricted.valid_moves
        king_restricted.legal_moves
        valid_list = king_restricted.instance_variable_get(:@moves)
        expect(valid_list).to match_array([[0, 3], [0, 5], [1, 3], [1, 5]])
      end

      it 'does not remove a move where an enemy players piece is currently occupying' do
        board.update_piece([0, 4], king_restricted)
        king_restricted.instance_variable_set(:@moves, [])
        black_pawn = Pawn.new([1, 4], 'Black', board)
        board.update_piece([1, 4], black_pawn)
        black_pawn.valid_moves
        king_restricted.valid_moves
        king_restricted.legal_moves
        valid_list = king_restricted.instance_variable_get(:@moves)
        expect(valid_list).to match_array([[1, 3], [1, 5], [1, 4]])
      end

      it 'removes a move where the king would be in check' do
        board.update_piece([0, 4], king_restricted)
        king_restricted.instance_variable_set(:@moves, [])
        knight = Knight.new([1, 4], 'Black', board)
        board.update_piece([1, 4], knight)
        king_restricted.valid_moves
        king_restricted.legal_moves
        valid_list = king_restricted.instance_variable_get(:@moves)
        expect(valid_list).to match_array([[1, 3], [0, 3], [0, 5], [1, 5], [1, 4]])
      end
    end
  end

  describe '#king_side_rook' do
    let(:board) { Board.new }
    let(:white_rook) { Rook.new([0, 7], 'White', board) }
    let(:black_rook) { Rook.new([7, 7], 'Black', board) }
    let(:black_king) { King.new([7, 4], 'Black', board) }
    subject(:king_castling) { King.new([0, 4], 'White', board) }
    
    before do
      board.update_piece([0, 7], white_rook)
      board.update_piece([0, 4], king_castling)
      board.update_piece([7, 7], black_rook)
      board.update_piece([7, 4], black_king)
    end

    it 'finds the appropriate rook for the white player color' do
      castling_rook = king_castling.king_side_rook
      expect(castling_rook).to eq(white_rook)
    end

    it 'finds the appropriate rook for the black player color' do
      castling_rook = black_king.king_side_rook
      expect(castling_rook).to eq(black_rook)
    end
  end

end
