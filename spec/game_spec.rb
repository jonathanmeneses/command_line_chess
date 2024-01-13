# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'rspec'
require_relative '../lib/board'
require_relative '../lib/game'
require_relative '../lib/piece'
require_relative '../lib/pieces_subclasses'

describe Game do
  describe '#valid_move?' do
    let(:board) { Board.new }
    let(:game) { Game.new(board) }
    let(:pawn) { Pawn.new([4, 1], :white) }
    let(:bishop) { Bishop.new([3, 0], :white) }
    let(:knight) { Knight.new([1, 0], :white) }
    let(:rook) { Rook.new([0,0], :white) }
    let(:queen) { Queen.new([4, 0], :white) }

    context 'when moving a pawn' do

      before do
        game.board.update_board_square(pawn.position[0],pawn.position[1],pawn)
      end
      it 'returns true for a valid forward move' do
        expect(game.valid_move?(pawn, [4, 2])).to be true
      end

      it 'returns true for a double move' do
        expect(game.valid_move?(pawn, [4, 3])).to be true
      end

      it 'returns false for an invalid move' do
        expect(game.valid_move?(pawn, [4, 4])).to be false
      end
    end

    context 'when moving a bishop' do
      before do
        game.board.update_board_square(pawn.position[0],pawn.position[1],pawn)
      end

      it 'returns true for a valid diagonal move' do
        expect(game.valid_move?(bishop, [5,2])).to be false
      end

      it 'returns false for an invalid diagonal move' do
        expect(game.valid_move?(bishop, [3,2])).to be false
      end
    end

    context 'when moving a knight' do
      before do
        game.board.update_board_square(1,1,pawn)
        game.board.update_board_square(knight.position[0],knight.position[1],knight)
      end
      it 'returns true for a valid knight move' do
        expect(game.valid_move?(knight, [3,1])).to be true
      end

      it 'returns false for an invalid knight move' do
        expect(game.valid_move?(knight, [3,2])).to be false
      end

      it 'returns false for an invalid knight move' do
        expect(game.valid_move?(knight, [-1,1])).to be false
      end
    end

    context 'when moving a Rook' do
      it 'returns true for a valid Rook move' do
        expect(game.valid_move?(rook, [3,0])).to be true
      end

      it 'returns false for an invalid knight move' do
        expect(game.valid_move?(rook, [3,2])).to be false
      end
    end

    context 'when moving a queen' do
      it 'returns true for a valid horizontal move' do
        expect(game.valid_move?(queen, [2,0])).to be true
      end

      it 'returns true for a valid vertical move' do
        expect(game.valid_move?(queen, [4,5])).to be true
      end

      it 'returns false for an valid diagonal move' do
        expect(game.valid_move?(queen, [6,2])).to be true
      end

      it 'returns false for an invalid diagnoal move' do
        expect(game.valid_move?(queen, [6,3])).to be false
      end
    end
    # Similarly, add contexts for other pieces like Knight, Bishop, etc.
  end


end
