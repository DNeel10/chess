require './lib/board'
require './lib/pawn'

describe Pawn do
  context 'the player is using white pieces' do
    let(:board) { Board.new }
    subject(:pawn_moves) { described_class.new([1, 0], 'White', board)}

    describe '#valid_moves' do
      it 'updates the move array with two moves if its the first move' do
        move_array = pawn_moves.instance_variable_get(:@moves)
        pawn_moves.valid_moves(board)
        expect(move_array).to match_array([[2, 0], [3, 0]])
      end

      it 'updates the move array with one move if its not the first move' do
        move_array = pawn_moves.instance_variable_get(:@moves)
        pawn_moves.instance_variable_set(:@first_move, false)
        pawn_moves.valid_moves(board)
        expect(move_array).to match_array([[2, 0]])
      end
    end

    describe '#move_one_space' do
      it 'adds the coordinates one space forward to the moves array' do
        move_array = pawn_moves.instance_variable_get(:@moves)
        pawn_moves.move_one_space(board)
        expect(move_array).to match_array([[2, 0]])
      end
    end

    describe '#initial_move' do
      it 'adds the coordinates two spaces forward to the moves array' do
        move_array = pawn_moves.instance_variable_get(:@moves)
        pawn_moves.initial_move(board)
        expect(move_array).to match_array([[2, 0], [3, 0]])
      end
    end


  end
end