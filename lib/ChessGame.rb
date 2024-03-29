# frozen_string_literal: true
# rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/ClassLength, Metrics/CyclomaticComplexity

require 'pry-byebug'
require 'yaml'

require_relative '../lib/board'
require_relative '../lib/piece'
require_relative '../lib/pieces_subclasses'
require_relative '../lib/game'

class ChessGame
  attr_accessor :board, :game
  def initialize
    @board = Board.new
    @game = Game.new(@board)
    setup_pieces
    @current_player = :white
    @game_saved = nil
  end

  def play_game
    loop do
      # begin
        @board.display_board
        break if game_over?
        process_turn

        switch_player
      # rescue StandardError => e
      #   puts e.message
      #   retry
    end
    binding.pry
    conclude_game
  end

  private

  def setup_pieces
    # Setting up White Pieces
    place_pieces(0, :white)

    # Setting up Black Pieces
    place_pieces(7, :black)

    # Setting up Pawns
    @board.grid[1].each_index { |i| @board.update_board_square(i, 1, Pawn.new([i, 1], :white)) }
    @board.grid[6].each_index { |i| @board.update_board_square(i, 6, Pawn.new([i, 6], :black)) }
  end

  def place_pieces(back_row, color)
    pieces_order = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]


    pieces_order.each_with_index do |piece_class, i|
      @board.update_board_square(i, back_row, piece_class.new([i, back_row], color))
    end
  end

  def save_game()
    game_state = {
      board: @board,
      game: @game,
      current_player: @current_player
    }

    yaml = YAML.dump(game_state)
    File.write("chess_save.yml",yaml)
    @game_saved = true
  end

  def load_game()
    unless File.exist?("chess_save.yml")
      puts "No saved game exists!"
      return nil
    end
    yaml_content = File.read("chess_save.yml")
    file = YAML.safe_load(yaml_content, permitted_classes: [Board, Pawn, Knight, Bishop, Rook, Queen, King, Game, Symbol], aliases:true)

    @game = file[:game]
    @board = file[:board]
    @current_player = [:current_player]
    @game_saved = nil
    return true
  end

  def game_over?
    @game.checkmate?(@current_player, @board) || @game_saved # || @game.is_stalemate(@current_player)
  end

  def in_check?
    @game.color_in_check?(@current_player,@board)
  end

  def process_turn
    puts "#{@current_player.capitalize} is in check!" if in_check?
    puts "#{@current_player.capitalize}'s turn."
    move = get_player_move
    if move == 'save'
      save_game
    elsif move == 'load'
      load_game
    else
      piece = @board.grid[move[:from][1]][move[:from][0]]
      validate_move(piece, move)
      @game.move_piece(piece, move[:to], @board)
    end
  end

  def get_player_move
    move = nil
    loop do
      puts "Enter your move!"

      begin
        input = gets.chomp
        if input.downcase == 'save' || input.downcase =='load'
          return input.downcase
        elsif input.length != 4
          raise ArgumentError, "Move should be 4 characters (from:to), provided input is #{input.length}"
        end

        from = input[0..1]
        to = input[2..]

        move = { from: @board.alphanumeric_to_array_notation(from),
                 to: @board.alphanumeric_to_array_notation(to) }


        break
      rescue StandardError => e
        puts e.message
      end
    end
    move
  end

  def validate_move(piece, move)
    raise 'Invalid move' unless piece && piece.color == @current_player
    raise 'Invalid move' unless @game.valid_move?(piece, move[:to], board)
  end

  def switch_player
    @current_player = @current_player == :white ? :black : :white
  end

  def conclude_game
    if @game.checkmate?(@current_player,@board)
      winner = @current_player == :white ? :black : :white
      puts "Checkmate! #{winner.capitalize} wins."
    # elsif @game.is_stalemate(@current_player)
    #   puts "Stalemate! The game is a draw."
    else
      puts "Game Saved!"
    end
  end
end
