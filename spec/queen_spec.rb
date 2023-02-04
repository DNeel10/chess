require './lib/queen'
require './lib/board'
require './lib/knight'

describe Queen do
  describe '#valid_moves' do
    let(:board_grid) { Board.new }
    subject(:queen_move) { described_class.new([3, 3], 'White', board_grid) }


    before do
      allow(board_grid).to receive(:open_space?).and_return true
      allow(board_grid).to receive(:players_piece?).and_return false
    end

    it 'returns an array of moves in each direction' do
      queen_move.instance_variable_set(:@moves, [])
      queen_move.valid_moves
      move_array = queen_move.instance_variable_get(:@moves)
      expect(move_array).to match_array([[4, 3], [5, 3], [6, 3], [7, 3], # move_up
                                         [2, 3], [1, 3], [0, 3],         # move_down
                                         [3, 4], [3, 5], [3, 6], [3, 7], # move_right
                                         [3, 2], [3, 1], [3, 0],         # move_left
                                         [4, 4], [5, 5], [6, 6], [7, 7], # move_up_right
                                         [2, 2], [1, 1], [0, 0],         # move_down_left
                                         [4, 2], [5, 1], [6, 0],         # move_up_left
                                         [2, 4], [1, 5], [0, 6]])        # move_down_right
    end
  end

  describe '#move_right' do
    let(:board_grid) { Board.new }
    subject(:queen_right) { described_class.new([0, 0], 'White', board_grid) }

    before do
      allow(board_grid).to receive(:open_space?).and_return true
      allow(board_grid).to receive(:players_piece?).and_return false
    end

    it 'returns an array of moves in the horizontal right direction' do
      queen_right.instance_variable_set(:@moves, [])
      move_right_array = queen_right.instance_variable_get(:@moves)
      queen_right.move_right
      expect(move_right_array).to eq([[0, 1], [0, 2], [0, 3], [0, 4],
                                      [0, 5], [0, 6], [0, 7]])
    end
  end

  describe '#move_up' do
    let(:board_grid) { Board.new }
    subject(:queen_up) { described_class.new([0, 0], 'White', board_grid) }

    before do
      allow(board_grid).to receive(:open_space?).and_return true
      allow(board_grid).to receive(:players_piece?).and_return false
    end

    it 'returns an array of moves in the vertical up direction' do
      queen_up.instance_variable_set(:@moves, [])
      move_up_array = queen_up.instance_variable_get(:@moves)
      queen_up.move_up
      expect(move_up_array).to eq([[1, 0], [2, 0], [3, 0], [4, 0],
                                   [5, 0], [6, 0], [7, 0]])
    end
  end

  describe '#move_left' do
    let(:board_grid) { Board.new }
    subject(:queen_left) { described_class.new([0, 7], 'White', board_grid) }

    before do
      allow(board_grid).to receive(:open_space?).and_return true
      allow(board_grid).to receive(:players_piece?).and_return false
    end

    it 'returns an array of moves in the horizontal left direction' do
      queen_left.instance_variable_set(:@moves, [])
      move_left_array = queen_left.instance_variable_get(:@moves)
      queen_left.move_left
      expect(move_left_array).to eq([[0, 6], [0, 5], [0, 4], [0, 3],
                                     [0, 2], [0, 1], [0, 0]])
    end
  end

  describe '#move_down' do
    let(:board_grid) { Board.new }
    subject(:queen_down) { described_class.new([7, 0], 'White', board_grid) }

    before do
      allow(board_grid).to receive(:open_space?).and_return true
      allow(board_grid).to receive(:players_piece?).and_return false
    end

    it 'returns an array of moves in the vertical down direction' do
      queen_down.instance_variable_set(:@moves, [])
      move_down_array = queen_down.instance_variable_get(:@moves)
      queen_down.move_down
      expect(move_down_array).to eq([[6, 0], [5, 0], [4, 0], [3, 0],
                                     [2, 0], [1, 0], [0, 0]])
    end
  end
  describe '#move_up_right' do
    let(:board_grid) { Board.new }
    subject(:queen_up_right) { described_class.new([0, 0], 'White', board_grid) }

    before do
      allow(board_grid).to receive(:open_space?).and_return true
      allow(board_grid).to receive(:players_piece?).and_return false
    end

    it 'returns an array of moves in the diagonal up right direction' do
      queen_up_right.instance_variable_set(:@moves, [])
      move_up_right_array = queen_up_right.instance_variable_get(:@moves)
      queen_up_right.move_up_right
      expect(move_up_right_array).to eq([[1, 1], [2, 2], [3, 3], [4, 4],
                                      [5, 5], [6, 6], [7, 7]])
    end
  end

  describe '#move_down_right' do
    let(:board_grid) { Board.new }
    subject(:queen_down_right) { described_class.new([7, 0], 'White', board_grid) }

    before do
      allow(board_grid).to receive(:open_space?).and_return true
      allow(board_grid).to receive(:players_piece?).and_return false
    end

    it 'returns an array of moves in the diagonal down right direction' do
      queen_down_right.instance_variable_set(:@moves, [])
      move_down_right_array = queen_down_right.instance_variable_get(:@moves)
      queen_down_right.move_down_right
      expect(move_down_right_array).to eq([[6,1], [5, 2], [4, 3], [3, 4], [2, 5], [1, 6], [0, 7]])
    end
  end

  describe '#move_up_left' do
    let(:board_grid) { Board.new }
    subject(:queen_up_left) { described_class.new([0, 7], 'White', board_grid) }

    before do
      allow(board_grid).to receive(:open_space?).and_return true
      allow(board_grid).to receive(:players_piece?).and_return false
    end

    it 'returns an array of moves in the diagonal up left direction' do
      queen_up_left.instance_variable_set(:@moves, [])
      move_up_left_array = queen_up_left.instance_variable_get(:@moves)
      queen_up_left.move_up_left
      expect(move_up_left_array).to eq([[1, 6], [2, 5], [3, 4], [4, 3], [5, 2], [6, 1], [7, 0]])
    end
  end

  describe '#move_down_left' do
    let(:board_grid) { Board.new }
    subject(:queen_down_left) { described_class.new([7, 7], 'White', board_grid) }

    before do
      allow(board_grid).to receive(:open_space?).and_return true
      allow(board_grid).to receive(:players_piece?).and_return false
    end

    it 'returns an array of moves in the diagonal down left direction' do
      queen_down_left.instance_variable_set(:@moves, [])
      move_down_left_array = queen_down_left.instance_variable_get(:@moves)
      queen_down_left.move_down_left
      expect(move_down_left_array).to eq([[6, 6], [5, 5], [4, 4], [3, 3], [2, 2], [1, 1], [0, 0]])
    end
  end

  context "a piece has other player pieces in its path" do
    let(:board_grid) { Board.new }
    subject(:queen_impeded) { described_class.new([3, 3], 'White', board_grid) }

    it 'prevents moves when a piece blocks its path' do
      queen_impeded.instance_variable_set(:@moves, [])
      down_left_array = queen_impeded.instance_variable_get(:@moves)
      board_grid.grid[2][2] = Knight.new([2, 2], 'White', board_grid)
      queen_impeded.move_down_left
      expect(down_left_array).to eq([])
    end
  end
end
