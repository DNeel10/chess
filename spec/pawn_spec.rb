require './lib/board'
require './lib/pawn'
require './lib/rook'

describe Pawn do
  context 'the player is using white pieces' do
    let(:board) { Board.new }
    subject(:pawn_moves) { described_class.new([1, 0], 'White', board)}

    describe '#valid_moves' do
      it 'updates the move array with two moves if its the first move' do
        pawn_moves.instance_variable_set(:@moves, [])
        pawn_moves.instance_variable_set(:@first_move, true)
        pawn_moves.valid_moves
        move_array = pawn_moves.instance_variable_get(:@moves)
        expect(move_array).to match_array([[2, 0], [3, 0]])
      end

      it 'updates the move array with one move if its not the first move' do
        pawn_moves.instance_variable_set(:@moves, [])
        pawn_moves.instance_variable_set(:@first_move, false)
        pawn_moves.valid_moves
        move_array = pawn_moves.instance_variable_get(:@moves)
        expect(move_array).to match_array([[2, 0]])
      end

      it 'updates the move array with diagonal attack moves when an opponent piece is in position' do
        pawn_moves.instance_variable_set(:@moves, [])
        pawn_moves.instance_variable_set(:@first_move, false)
        rook = Rook.new([2, 1], 'Black', board)
        board.grid[2][1] = rook
        pawn_moves.valid_moves
        move_array = pawn_moves.instance_variable_get(:@moves)
        expect(move_array).to match_array([[2, 0], [2, 1]])
      end
    end

    describe '#move_one_space' do
      it 'adds the coordinates one space forward to the moves array' do
        pawn_moves.instance_variable_set(:@moves, [])
        move_array = pawn_moves.instance_variable_get(:@moves)
        pawn_moves.move_one_space
        expect(move_array).to match_array([[2, 0]])
      end

      it 'excludes a space if a piece is occupying it' do
        pawn_moves.instance_variable_set(:@moves, [])
        rook = Rook.new([2, 0], 'Black', board)
        board.grid[2][0] = rook
        move_array = pawn_moves.instance_variable_get(:@moves)
        pawn_moves.move_one_space
        expect(move_array).to match_array([])
      end
    end

    describe '#initial_move' do
      it 'adds the coordinates two spaces forward to the moves array' do
        pawn_moves.instance_variable_set(:@moves, [])
        move_array = pawn_moves.instance_variable_get(:@moves)
        pawn_moves.initial_move
        expect(move_array).to match_array([[2, 0], [3, 0]])
      end
    end

    describe '#white_attack_moves' do
      it 'adds diagonal move coordinates if an opponent piece is occupying' do
        pawn_moves.instance_variable_set(:@moves, [])
        rook = Rook.new([2, 1], 'Black', board)
        board.grid[2][1] = rook
        move_array = pawn_moves.instance_variable_get(:@moves)
        pawn_moves.white_attack_moves
        expect(move_array).to match_array([[2, 1]])
      end

      it "doesn't add diagonal move if a player's piece is occupying" do
        pawn_moves.instance_variable_set(:@moves, [])
        rook = Rook.new([2, 1], 'White', board)
        board.grid[2][1] = rook
        move_array = pawn_moves.instance_variable_get(:@moves)
        pawn_moves.white_attack_moves
        expect(move_array).to match_array([])
      end
    end
  end

  context 'the player is using black pieces' do
    let(:board) { Board.new }
    subject(:pawn_moves) { described_class.new([6, 0], 'Black', board) }

    describe '#valid_moves' do
      it 'updates the move array with two moves if its the first move' do
        pawn_moves.instance_variable_set(:@moves, [])
        pawn_moves.instance_variable_set(:@first_move, true)
        pawn_moves.valid_moves
        move_array = pawn_moves.instance_variable_get(:@moves)
        expect(move_array).to match_array([[5, 0], [4, 0]])
      end

      it 'updates the move array with one move if its not the first move' do
        pawn_moves.instance_variable_set(:@moves, [])
        pawn_moves.instance_variable_set(:@first_move, false)
        pawn_moves.valid_moves
        move_array = pawn_moves.instance_variable_get(:@moves)
        expect(move_array).to match_array([[5, 0]])
      end

      it 'updates the move array with diagonal attack moves when an opponent piece is in position' do
        pawn_moves.instance_variable_set(:@moves, [])
        pawn_moves.instance_variable_set(:@first_move, false)
        rook = Rook.new([5, 1], 'White', board)
        board.grid[5][1] = rook
        pawn_moves.valid_moves
        move_array = pawn_moves.instance_variable_get(:@moves)
        expect(move_array).to match_array([[5, 0], [5, 1]])
      end
    end

    describe '#move_one_space' do
      it 'adds the coordinates one space forward to the moves array' do
        pawn_moves.instance_variable_set(:@moves, [])
        move_array = pawn_moves.instance_variable_get(:@moves)
        pawn_moves.move_one_space
        expect(move_array).to match_array([[5, 0]])
      end

      it 'excludes a space if a piece is occupying it' do
        pawn_moves.instance_variable_set(:@moves, [])
        rook = Rook.new([5, 0], 'White', board)
        board.grid[5][0] = rook
        move_array = pawn_moves.instance_variable_get(:@moves)
        pawn_moves.move_one_space
        expect(move_array).to match_array([])
      end
    end

    describe '#initial_move' do
      it 'adds the coordinates two spaces forward to the moves array' do
        pawn_moves.instance_variable_set(:@moves, [])
        move_array = pawn_moves.instance_variable_get(:@moves)
        pawn_moves.initial_move
        expect(move_array).to match_array([[5, 0], [4, 0]])
      end
    end

    describe '#black_attack_moves' do
      it 'adds diagonal move coordinates if an opponent piece is occupying' do
        pawn_moves.instance_variable_set(:@moves, [])
        rook = Rook.new([5, 1], 'White', board)
        board.grid[5][1] = rook
        move_array = pawn_moves.instance_variable_get(:@moves)
        pawn_moves.black_attack_moves
        expect(move_array).to match_array([[5, 1]])
      end

      it "doesn't add diagonal move if a player's piece is occupying" do
        pawn_moves.instance_variable_set(:@moves, [])
        rook = Rook.new([5, 1], 'Black', board)
        board.grid[5][1] = rook
        move_array = pawn_moves.instance_variable_get(:@moves)
        pawn_moves.black_attack_moves
        expect(move_array).to match_array([])
      end
    end
  end
end