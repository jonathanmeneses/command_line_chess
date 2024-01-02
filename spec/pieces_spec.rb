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

    context 'when a white pawn is in the initial row' do
      let(:pawn) { described_class.new(:white,[1,1]) }
      it 'moves in a positive direction' do
        potential_moves = pawn.potential_moves
        potential_moves.each do |x,y|
          expect(y).to be > pawn.position[1]
        end
      end
      it 'has 2 and 1 jumps available' do
        potential_moves = pawn.potential_moves
        potential_moves.each do |x,y|
          y_length = (y-pawn.position[1]).abs
          expect([1,2]).to include(y_length)
        end
      end
    end
    context 'when a black pawn is in the initial row' do
      let(:pawn) { described_class.new(:black,[1,6]) }
      it 'moves in a negative direction' do
        potential_moves = pawn.potential_moves
        potential_moves.each do |x,y|
          expect(y).to be < pawn.position[1]
        end
      end
    end
  end

end
