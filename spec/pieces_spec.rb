# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'rspec'
require_relative '../lib/board'
require_relative '../lib/game'
require_relative '../lib/piece'
require_relative '../lib/pieces_subclasses'

describe Pawn do
  describe '#initialize' do
    subject(:pawn) { described_class.new(:white,[1,1]) }
    context 'when a new pawn is created' do
      it 'it has position and color' do
        expect(pawn.position).to eq([1,1])
        expect(pawn.color).to eq(:white)
      end
    end
  end

  describe '#potential_moves' do
    context 'when a pawn is in the initial row' do
      xit 'moves in a positive direction' do
      end
      xit 'has 2 and 1 jumpts available' do
      end
    end
  end

end
