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

  describe '#king_in_check?' do
    let(:board) { Board.new }
    let(:game) { Game.new(board) }
    let(:king) { King.new([0, 0], :white) }
    let(:pawn) { Pawn.new([1,1], :white) }
    let(:b_bishop) { Bishop.new([3, 3], :black) }
    context 'when the king is not in check' do
      before do
        game.board.update_board_square(pawn.position[0],pawn.position[1],pawn)
        game.board.update_board_square(king.position[0],king.position[1],king)
        game.board.update_board_square(b_bishop.position[0],b_bishop.position[1],b_bishop)
      end

      it 'returns false' do
        expect(game.king_in_check?(:white,king,board)).to be false
      end

      it 'returns false for the wrong team' do
        expect(game.king_in_check?(:black,king,board)).to be false
      end
    end

    context 'when the king is in check' do
      before do
        game.board.update_board_square(king.position[0],king.position[1],king)
        game.board.update_board_square(b_bishop.position[0],b_bishop.position[1],b_bishop)
      end

      it 'returns true' do
        expect(game.king_in_check?(:white,king,board)).to be true
      end

    end
  end

  describe '#color_in_check?' do
    let(:board) { Board.new }
    let(:game) { Game.new(board) }
    let(:king) { King.new([0, 0], :white) }
    let(:pawn) { Pawn.new([1,1], :white) }
    let(:b_bishop) { Bishop.new([3, 3], :black) }

    context 'when the king is not in check' do
      before do
        allow(game).to receive(:locate_king).and_return(king)
        game.board.update_board_square(pawn.position[0],pawn.position[1],pawn)
        game.board.update_board_square(king.position[0],king.position[1],king)
        game.board.update_board_square(b_bishop.position[0],b_bishop.position[1],b_bishop)
      end

      it 'returns false' do
        expect(game.color_in_check?(:white,board)).to be false
      end

      it 'returns false for the wrong team' do
        expect(game.color_in_check?(:black,board)).to be false
      end
    end

    context 'when the king is in check' do
      before do
        allow(game).to receive(:locate_king).and_return(king)
        game.board.update_board_square(king.position[0],king.position[1],king)
        game.board.update_board_square(b_bishop.position[0],b_bishop.position[1],b_bishop)
      end

      it 'returns true' do
        expect(game.color_in_check?(:white,board)).to be true
      end

      it 'returns false for the wrong team' do
        expect(game.color_in_check?(:black,board)).to be false
      end
    end

  end


  describe '#move_place_player_in_check?' do
    let(:board) { Board.new }
    let(:game) { Game.new(board) }
    let(:king) { King.new([0, 0], :white) }
    let(:pawn) { Pawn.new([1,1], :white) }
    let(:b_bishop) { Bishop.new([3, 2], :black) }

    context 'when a move does place a king in check' do
      before do
        game.board.update_board_square(pawn.position[0],pawn.position[1],pawn)
        game.board.update_board_square(king.position[0],king.position[1],king)
        game.board.update_board_square(b_bishop.position[0],b_bishop.position[1],b_bishop)
      end

      it 'returns true' do
        expect(game.move_place_player_in_check?(king,1,0)).to be true
      end
    end
  end


end
