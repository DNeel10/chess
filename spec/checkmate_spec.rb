require './lib/board'
require './lib/checkmate'
require './lib/rook'
require './lib/king'
require './lib/queen'
require './lib/knight'
require './lib/bishop'
require './lib/checkfinder'

describe Checkmate do

  describe '#checkmate?' do
    context 'none of the white pieces can make a legal move' do
      let(:board) { Board.new } 
      subject(:white_checkmate) { described_class.new(board, 'White', Checkfinder.new(board)) }

      before do
        black_rook = Rook.new([1, 0], 'Black', board)
        board.update_piece([1, 0], black_rook)
        black_rook.position = [1, 0]
        black_queen = Queen.new([0, 0], 'Black', board)
        board.update_piece([0, 0], black_queen)
        black_queen.position = [0, 0]
        white_king = King.new([0, 4], 'White', board)
        board.update_piece([0, 4], white_king)
        white_king.position = [0, 4]
        board.update_all_pieces
        white_king.legal_moves
        puts "#{white_king.moves}" 
      end

      it 'returns true when the available white pieces all have empty move arrays' do
        expect(white_checkmate.no_moves_left?).to be true
      end

      it 'returns true when the king is currently in check' do
        expect(white_checkmate.king_in_check?).to be true
      end

      it 'returns true if both conditions are met' do
        expect(white_checkmate.checkmate?).to be true
      end
    end

    context 'a piece has the ability to block the check' do
      let(:board) { Board.new }
      subject(:not_checkmate) { described_class.new(board, 'White', Checkfinder.new(board)) }

      before do
        black_rook = Rook.new([1, 0], 'Black', board)
        board.update_piece([1, 0], black_rook)
        black_queen = Queen.new([0, 0], 'Black', board)
        board.update_piece([0, 0], black_queen)
        white_king = King.new([1, 4], 'White', board)
        board.update_piece([1, 4], white_king)
        white_rook = Rook.new([2, 3], 'White', board)
        board.update_piece([2, 3], white_rook)
        board.update_all_pieces
        white_king.legal_moves
        white_rook.legal_moves
      end

      it 'returns false when the available white pieces have at least one move available' do
        expect(not_checkmate.no_moves_left?).to be false
      end

      it 'returns true when the king is in check' do
        expect(not_checkmate.king_in_check?).to be true
      end

      it 'returns false when both conditions are not met' do
        expect(not_checkmate.checkmate?).to be false
      end
    end
  end

  describe '#stalemate' do
    context 'no moves are available, but the king is not in check' do
      let(:board) { Board.new }
      subject(:stalemate) { described_class.new(board, 'White', Checkfinder.new(board)) }

      before do
        black_rook = Rook.new([2, 0], 'Black', board)
        board.update_piece([2, 0], black_rook)
        black_queen = Queen.new([3, 3], 'Black', board)
        board.update_piece([3, 3], black_queen)
        black_bishop = Bishop.new([2, 4], 'Black', board)
        board.update_piece([2, 4], black_bishop)
        black_knight = Knight.new([0, 4], 'Black', board)
        board.update_piece([0, 4], black_knight)
        black_rook_two = Rook.new([1, 7], 'Black', board)
        board.update_piece([1, 7], black_rook_two)
        white_king = King.new([0, 1], 'White', board)
        board.update_piece([0, 1], white_king)
        board.update_all_pieces
        white_king.legal_moves
      end

      it 'returns true when the available white pieces have no moves available' do
        expect(stalemate.no_moves_left?).to be true
      end

      it 'returns false when the king is not in check' do
        expect(stalemate.king_in_check?).to be false
      end

      it 'returns true when the king is not in check but there are no legal moves left' do
        expect(stalemate.stalemate?).to be true
      end
    end
  end
end
