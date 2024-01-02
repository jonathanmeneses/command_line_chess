# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'rspec'
require_relative '../lib/board'
require_relative '../lib/game'

describe Board do
  describe '#initialize' do
    subject(:board) { described_class.new }
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

  describe '#alphanumeric_to_array_notation' do
    subject(:board) {described_class.new}

    context 'when a valid alphanumeric location is passed' do
      xit 'returns a valid array row & column combination' do
      end
    end

    context 'when an invalid alphanumeric location is passed' do
      xit 'returns an error' do
      end
    end
  end

  describe '#array_to_alphanumeric_notation' do
    subject(:board) {described_class.new}

    context 'when a valid array location is passed' do
      xit 'returns a valid alphanumeric location' do
        expect(board.array_to_alphanumeric_notation(0,0)).to eq('a1')
      end
    end

    context 'when an invalid array location is passed' do
      it 'returns an error' do
        expect(board.array_to_alphanumeric_notation(12,2)).to raise_error(RangeError)
      end
      xit 'returns an error' do
        expect(board.array_to_alphanumeric_notation(1,12)).to raise_error(RangeError)
      end
    end
  end
end
