require './lib/bishop'
require './lib/board'
require './lib/knight'

describe Bishop do
  describe '#valid_moves' do
    let(:board_grid) { Board.new }
    subject(:bishop_move) { described_class.new([5, 5], 'White', board_grid) }

    before do
      allow(board_grid).to receive(:open_space?).and_return true
      allow(board_grid).to receive(:players_piece?).and_return false
    end

    it 'returns an array of moves in all direction' do
      bishop_move.instance_variable_set(:@moves, [])
      bishop_move.valid_moves
      move_array = bishop_move.instance_variable_get(:@moves)
      expect(move_array).to match_array([[0, 0], [1, 1], [2, 2], [3, 3], [4, 4], [6, 6],
                                         [7, 7], [6, 4], [7, 3], [4, 6], [3, 7]])
    end
  end

  describe '#move_up_right' do
    let(:board_grid) { Board.new }
    subject(:bishop_up_right) { described_class.new([0, 0], 'White', board_grid) }

    before do
      allow(board_grid).to receive(:open_space?).and_return true
      allow(board_grid).to receive(:players_piece?).and_return false
    end

    it 'returns an array of moves in the diagonal up right direction' do
      bishop_up_right.instance_variable_set(:@moves, [])
      move_up_right_array = bishop_up_right.instance_variable_get(:@moves)
      bishop_up_right.move_up_right
      expect(move_up_right_array).to eq([[1, 1], [2, 2], [3, 3], [4, 4],
                                         [5, 5], [6, 6], [7, 7]])
    end
  end

  describe '#move_down_right' do
    subject(:bishop_down_right) { described_class.new([7, 0], 'White', board_grid) }
    let(:board_grid) { Board.new }

    before do
      allow(board_grid).to receive(:open_space?).and_return true
      allow(board_grid).to receive(:players_piece?).and_return false
    end

    it 'returns an array of moves in the diagonal down right direction' do
      bishop_down_right.instance_variable_set(:@moves, [])
      move_down_right_array = bishop_down_right.instance_variable_get(:@moves)
      bishop_down_right.move_down_right
      expect(move_down_right_array).to eq([[6, 1], [5, 2], [4, 3], [3, 4], [2, 5], [1, 6], [0, 7]])
    end
  end

  describe '#move_up_left' do
    let(:board_grid) { Board.new }
    subject(:bishop_up_left) { described_class.new([0, 7], 'White', board_grid) }

    before do
      allow(board_grid).to receive(:open_space?).and_return true
      allow(board_grid).to receive(:players_piece?).and_return false
    end

    it 'returns an array of moves in the diagonal up left direction' do
      bishop_up_left.instance_variable_set(:@moves, [])
      move_up_left_array = bishop_up_left.instance_variable_get(:@moves)
      bishop_up_left.move_up_left
      expect(move_up_left_array).to eq([[1, 6], [2, 5], [3, 4], [4, 3], [5, 2], [6, 1], [7, 0]])
    end
  end

  describe '#move_down_left' do
    let(:board_grid) { Board.new }
    subject(:bishop_down_left) { described_class.new([7, 7], 'White', board_grid) }

    before do
      allow(board_grid).to receive(:open_space?).and_return true
      allow(board_grid).to receive(:players_piece?).and_return false
    end

    it 'returns an array of moves in the diagonal down left direction' do
      bishop_down_left.instance_variable_set(:@moves, [])
      move_down_left_array = bishop_down_left.instance_variable_get(:@moves)
      bishop_down_left.move_down_left
      expect(move_down_left_array).to eq([[6, 6], [5, 5], [4, 4], [3, 3], [2, 2], [1, 1], [0, 0]])
    end
  end

  context 'a piece has other player pieces in its path' do
    let(:board_grid) { Board.new }
    subject(:bishop_impeded) { described_class.new([3, 3], 'White', board_grid) }

    it 'prevents moves when a piece blocks its path' do
      bishop_impeded.instance_variable_set(:@moves, [])
      board_grid.grid[2][2] = Knight.new([2, 2], 'White', board_grid)
      bishop_impeded.move_down_left
      down_left_array = bishop_impeded.instance_variable_get(:@moves)
      expect(down_left_array).to eq([])
    end
  end
end
