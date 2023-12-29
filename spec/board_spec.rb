# frozen_string_literal: true

require 'rspec'
require_relative '../lib/board'
require_relative '../lib/game'

describe Board do

  describe '#initialize' do
    subject(:board) { described_class.new }
    context 'when a new board is created' do
      xit 'it has 8 subarrays' do
        expect(board.grid.length).to eq(8)
      end

      xit 'each array contains 8 values' do
      end
  end

  describe '#display_board' do
  subject(:test_game) { described_class.new }
    context 'when called' do
      xit 'it puts 8 times' do

end
