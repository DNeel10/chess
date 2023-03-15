require './lib/rook'
require './lib/board'

describe Rook do
  describe '#valid_moves' do
    subject(:rook_move) { described_class.new([3, 3], 'White', board_grid) }
    let(:board_grid) { Board.new }

    before do
      allow(board_grid).to receive(:open_space?).and_return true
      allow(board_grid).to receive(:players_piece?).and_return false
    end

    it 'returns an array of moves in each direction' do
      rook_move.instance_variable_set(:@moves, [])
      rook_move.valid_moves
      move_array = rook_move.instance_variable_get(:@moves)
      expect(move_array).to match_array([[4, 3], [5, 3], [6, 3], [7, 3], # move_up
                                         [2, 3], [1, 3], [0, 3],         # move_down
                                         [3, 4], [3, 5], [3, 6], [3, 7], # move_right
                                         [3, 2], [3, 1], [3, 0]])        # move_left
    end
  end

  describe '#move_right' do
    subject(:rook_right) { described_class.new([0, 0], 'White', board_grid) }
    let(:board_grid) { Board.new }

    before do
      allow(board_grid).to receive(:open_space?).and_return true
      allow(board_grid).to receive(:players_piece?).and_return false
    end

    it 'returns an array of moves in the horizontal right direction' do
      rook_right.instance_variable_set(:@moves, [])
      rook_right.move_right
      move_right_array = rook_right.instance_variable_get(:@moves)
      expect(move_right_array).to eq([[0, 1], [0, 2], [0, 3], [0, 4],
                                      [0, 5], [0, 6], [0, 7]])
    end
  end

  describe '#move_up' do
    subject(:rook_up) { described_class.new([0, 0], 'White', board_grid) }
    let(:board_grid) { Board.new }

    before do
      allow(board_grid).to receive(:open_space?).and_return true
      allow(board_grid).to receive(:players_piece?).and_return false
    end

    it 'returns an array of moves in the vertical up direction' do
      rook_up.instance_variable_set(:@moves, [])
      move_up_array = rook_up.instance_variable_get(:@moves)
      rook_up.move_up
      expect(move_up_array).to eq([[1, 0], [2, 0], [3, 0], [4, 0],
                                   [5, 0], [6, 0], [7, 0]])
    end
  end

  describe '#move_left' do
    subject(:rook_left) { described_class.new([0, 7], 'White', board_grid) }
    let(:board_grid) { Board.new }

    before do
      allow(board_grid).to receive(:open_space?).and_return true
      allow(board_grid).to receive(:players_piece?).and_return false
    end

    it 'returns an array of moves in the horizontal left direction' do
      rook_left.instance_variable_set(:@moves, [])
      move_left_array = rook_left.instance_variable_get(:@moves)
      rook_left.move_left
      expect(move_left_array).to eq([[0, 6], [0, 5], [0, 4], [0, 3],
                                     [0, 2], [0, 1], [0, 0]])
    end
  end

  describe '#move_down' do
    subject(:rook_down) { described_class.new([7, 0], 'White', board_grid) }
    let(:board_grid) { Board.new }

    before do
      allow(board_grid).to receive(:open_space?).and_return true
      allow(board_grid).to receive(:players_piece?).and_return false
    end

    it 'returns an array of moves in the vertical down direction' do
      rook_down.instance_variable_set(:@moves, [])
      move_down_array = rook_down.instance_variable_get(:@moves)
      rook_down.move_down
      expect(move_down_array).to eq([[6, 0], [5, 0], [4, 0], [3, 0],
                                     [2, 0], [1, 0], [0, 0]])
    end
  end

  describe "#update_position" do
    subject(:rook_update) { described_class.new([0, 0], 'White', board_grid) }
    let(:board_grid) { Board.new }

    it 'updates the position of the piece' do
      rook_update.update_position([0, 7])
      rook_pos = rook_update.instance_variable_get(:@position)
      expect(rook_pos).to eq([0, 7])
    end
  end
end
