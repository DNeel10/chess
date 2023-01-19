require './lib/bishop'
require './lib/board'

describe Bishop do
  describe '#valid_moves' do
    subject(:bishop_move) { described_class.new([0, 0], 'White') }
    let(:board_grid) { Board.new }

    before do
      allow(board_grid).to receive(:open_space?).and_return true
      allow(board_grid).to receive(:players_piece?).and_return false
    end

    it 'returns an array of moves in each direction' do
      move_array = bishop_move.instance_variable_get(:@moves)
      bishop_move.valid_moves(board_grid)
      expect(move_array).to eq([[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]])
    end
  end

  describe '#move_up_right' do
    subject(:bishop_up_right) { described_class.new([0, 0], 'White') }
    let(:board_grid) { Board.new }

    before do
      allow(board_grid).to receive(:open_space?).and_return true
      allow(board_grid).to receive(:players_piece?).and_return false
    end

    it 'returns an array of moves in the diagonal up right direction' do
      move_up_right_array = bishop_up_right.instance_variable_get(:@moves)
      bishop_up_right.move_up_right(board_grid)
      expect(move_up_right_array).to eq([[1, 1], [2, 2], [3, 3], [4, 4],
                                      [5, 5], [6, 6], [7, 7]])
    end
  end
end
