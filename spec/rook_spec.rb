require './lib/rook'
require './lib/board'

describe Rook do
  describe '#valid_moves' do
    subject(:rook_move) { described_class.new([0, 0], 'White') }
    let(:board_grid) { Board.new }

    before do
      allow(board_grid).to receive(:open_space?).and_return true
      allow(board_grid).to receive(:players_piece?).and_return false
    end

    it 'returns an array of moves in each direction' do
      move_array = rook_move.instance_variable_get(:@moves)
      rook_move.valid_moves(board_grid)
      expect(move_array).to eq([[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
                                [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]])
    end
  end

  describe '#move_right' do
    subject(:rook_right) { described_class.new([0, 0], 'White') }
    let(:board_grid) { Board.new }

    before do
      allow(board_grid).to receive(:open_space?).and_return true
      allow(board_grid).to receive(:players_piece?).and_return false
    end

    it 'returns an array of moves in the horizontal right direction' do
      move_right_array = rook_right.instance_variable_get(:@moves)
      rook_right.move_right(board_grid)
      expect(move_right_array).to eq([[0, 1], [0, 2], [0, 3], [0, 4],
                                      [0, 5], [0, 6], [0, 7]])
    end
  end

  describe '#move_up' do
    subject(:rook_up) { described_class.new([0, 0], 'White') }
    let(:board_grid) { Board.new }

    before do
      allow(board_grid).to receive(:open_space?).and_return true
      allow(board_grid).to receive(:players_piece?).and_return false
    end

    it 'returns an array of moves in the vertical up direction' do
      move_up_array = rook_up.instance_variable_get(:@moves)
      rook_up.move_up(board_grid)
      expect(move_up_array).to eq([[1, 0], [2, 0], [3, 0], [4, 0],
                                   [5, 0], [6, 0], [7, 0]])
    end
  end

  describe '#move_left' do
    subject(:rook_left) { described_class.new([0, 7], 'White') }
    let(:board_grid) { Board.new }

    before do
      allow(board_grid).to receive(:open_space?).and_return true
      allow(board_grid).to receive(:players_piece?).and_return false
    end

    it 'returns an array of moves in the horizontal left direction' do
      move_left_array = rook_left.instance_variable_get(:@moves)
      rook_left.move_left(board_grid)
      expect(move_left_array).to eq([[0, 6], [0, 5], [0, 4], [0, 3],
                                     [0, 2], [0, 1], [0, 0]])
    end
  end

  describe '#move_down' do
    subject(:rook_down) { described_class.new([7, 0], 'White') }
    let(:board_grid) { Board.new }

    before do
      allow(board_grid).to receive(:open_space?).and_return true
      allow(board_grid).to receive(:players_piece?).and_return false
    end

    it 'returns an array of moves in the vertical down direction' do
      move_down_array = rook_down.instance_variable_get(:@moves)
      rook_down.move_down(board_grid)
      expect(move_down_array).to eq([[6, 0], [5, 0], [4, 0], [3, 0],
                                     [2, 0], [1, 0], [0, 0]])
    end
  end
end
