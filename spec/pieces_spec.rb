require './lib/pieces'

describe Pieces do
  describe '#generate_pieces' do
    context 'player is white pieces' do
      subject(:pieces_white) { described_class.new }

      it 'creates an array of all pieces' do
        pieces = pieces_white.generate_pieces('White')
        expect(pieces.length).to eq(16)
      end

      it 'creates all white pieces' do
        pieces = pieces_white.generate_pieces('White')
        pieces_color = pieces.all? { |piece| piece.color == 'White' }
        expect(pieces_color).to be true
      end
    end

    context 'player is black pieces' do
      subject(:pieces_white) { described_class.new }
      
      it 'creates an array of all pieces' do
        pieces = pieces_white.generate_pieces('Black')
        expect(pieces.length).to eq(16)
      end

      it 'creates all Black pieces' do
        pieces = pieces_white.generate_pieces('Black')
        pieces_color = pieces.all? { |piece| piece.color == 'Black' }
        expect(pieces_color).to be true
      end
    end
  end

  # test that initialize sends the message #generate_pieces to pieces
end