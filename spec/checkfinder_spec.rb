require './lib/checkfinder'
require './lib/board'
require './lib/king'
require './lib/queen'
require './lib/knight'

describe Checkfinder do
  subject(:check_finder) { described_class.new(board) }
  let(:board) { Board.new }

  describe '#in_check?' do
    it 'returns true if king is in check' do
      king = King.new([0, 4], 'White', board)
      board.update_piece([0, 4], king)
      knight = Knight.new([1, 2], 'Black', board)
      board.update_piece([1, 2], knight)
      knight.valid_moves
      expect(check_finder.in_check?(king)).to be true
    end

    it 'returns false if king is not in check' do
      king = King.new([0, 4], 'White', board)
      board.grid[0][4] = king
      knight = Knight.new([7, 2], 'Black', board)
      board.grid[7][2] = knight
      expect(check_finder.in_check?(king)).to be false
    end

    it 'does not include pieces that are the same color as the king' do
      king = King.new([0, 4], 'White', board)
      board.grid[0][4] = king
      white_knight = Knight.new([1, 2], 'White', board)
      board.grid[1][2] = white_knight
      black_knight = Knight.new([7, 2], 'Black', board)
      board.grid[7][2] = black_knight
      expect(check_finder.in_check?(king)).to be false
    end

    it 'properly prevents check if a piece is blocking the king' do
      white_king = King.new([0, 4], 'White', board)
      board.update_piece([0, 4], white_king)
      white_knight = Knight.new([0, 2], 'White', board)
      board.update_piece([0, 2], white_knight)
      black_queen = Queen.new([0, 1], 'Black', board)
      board.update_piece([0, 1], black_queen)
      expect(check_finder.in_check?(white_king)).to be false
    end
  end

  describe '#would_be_in_check' do
    it 'returns true if the potential move would put the king in check' do
      white_king = King.new([0, 4], 'White', board)
      board.grid[0][4] = white_king
      potential_move = [0, 3]
      black_knight = Knight.new([1, 5], 'Black', board)
      board.update_piece([1, 5], black_knight)
      expect(check_finder.would_be_in_check?(white_king, potential_move)).to be true
    end
  end
end
