require './lib/pieces'

describe Pieces do
  describe '#generate_pieces' do
    context 'player is white pieces' do
      let(:board) { Board.new }
      subject(:pieces_white) { described_class.new(board) }

      it 'creates an array of all pieces' do
        pieces = pieces_white.generate_pieces('White', board)
        expect(pieces.length).to eq(16)
      end

      it 'creates all white pieces' do
        pieces = pieces_white.generate_pieces('White', board)
        pieces_color = pieces.all? { |piece| piece.color == 'White' }
        expect(pieces_color).to be true
      end
    end

    context 'player is black pieces' do
      let(:board) { Board.new }
      subject(:pieces_white) { described_class.new(board) }

      it 'creates an array of all pieces' do
        pieces = pieces_white.generate_pieces('Black', board)
        expect(pieces.length).to eq(16)
      end

      it 'creates all Black pieces' do
        pieces = pieces_white.generate_pieces('Black', board)
        pieces_color = pieces.all? { |piece| piece.color == 'Black' }
        expect(pieces_color).to be true
      end
    end
  end
end
