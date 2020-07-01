# frozen_string_literal: true

WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]].freeze

# The game is played between 2 human players where each of them enters position
# they want to mark while taking turns. Playfield is simply an array of 9
# positions they can choose from.
class Game
  def initialize
    @playfield = Board.new
    @player1 = Player.new('Player 1', 'X', @playfield)
    @player2 = Player.new('Player 2', 'O', @playfield)
    @current_player = @player1
  end

  def play
    loop do
      @playfield.print

      puts "It's turn for #{@current_player.player_id}! Your marker is #{@current_player.marker}"
      puts 'Where do you want to put it?'

      @current_player.mark_spot
      break if game_should_end?

      switch_player
    end
  end

  def switch_player
    @current_player = if @current_player == @player1
                        @player2
                      else
                        @player1
                      end
  end

  def game_should_end?
    win? || draw?
  end

  def win?
    if @playfield.win_condition(@current_player.marker)
      @playfield.print
      puts "#{@current_player.player_id} wins!"
      true
    else
      false
    end
  end

  def draw?
    if @playfield.full?
      puts 'It\'s a draw!'
      true
    else
      false
    end
  end
end

# Player class objects are used to switch players between
# turns and for them to be able to mark a spot they want
class Player
  attr_accessor :player_id, :marker
  def initialize(player_id, marker, playfield)
    @player_id = player_id
    @marker = marker
    @playfield = playfield
  end

  def mark_spot
    loop do
      position = gets.chomp.to_i - 1

      if @playfield.legit_move?(position)
        @playfield.place_marker(position, @marker)
        break
      else
        puts 'That\'s not a legit move!'
      end
    end
  end
end

# Board class is used to operate on the game board
# mark spots, check win conditions, print board etc.
class Board
  def initialize
    @board = Array(1..9)
  end

  def full?
    @board.all? { |i| i.to_i.zero? }
  end

  def legit_move?(position)
    @board[position].is_a? Integer
  end

  def place_marker(position, marker)
    @board[position] = marker
  end

  def win_condition(marker)
    WIN_COMBINATIONS.any? do |line|
      a = @board[line[0]]
      b = @board[line[1]]
      c = @board[line[2]]
      a == marker && b == marker && c == marker
    end
  end

  def print
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts line = ' - - - - -'
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts line
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
end

tic_tac_toe = Game.new
tic_tac_toe.play
