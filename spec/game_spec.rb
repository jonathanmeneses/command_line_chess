# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'rspec'
require_relative '../lib/board'
require_relative '../lib/game'
require_relative '../lib/piece'
require_relative '../lib/pieces_subclasses'

describe Game do
  describe '#valid_move?' do
    subject(:game) { described_class.new }
    let(:board) {double('board')}
    context 'when a new board is created' do
      it 'it has 8 subarrays' do
        expect(board.grid.length).to eq(8)
      end

      it 'each array contains 8 values' do
        expect(board.grid[0].length).to eq(8)
      end
    end
  end

  describe '#update_board_square' do
    subject(:board) { described_class.new }

    context 'when board square is called with a valid location' do
      it 'it upddates the square with the value' do
        expect { board.update_board_square(2, 2, 'x') }
          .to change { board.grid[2][2] }
          .from(nil)
          .to('x')
      end
    end

    context 'when board square is called with an invalid location' do
      it 'it returns a range error' do
        expect { board.update_board_square(10, 10, 'x') }
          .to raise_error(RangeError)
      end
    end
  end
end
