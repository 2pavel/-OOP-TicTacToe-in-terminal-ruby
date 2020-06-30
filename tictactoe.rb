WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

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
      
      switch_player
    end
  end

  def switch_player
    if @current_player == @player1
      @current_player = @player2
    else
      @current_player = @player1
    end
  end
end

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

class Board
  def initialize
    @board = Array(1..9)
  end

  def full?
    @board.all { |i| i.to_i == 0 }
  end

  def legit_move?(position)
    @board[position].is_a? Integer
  end

  def place_marker(position, marker)
    @board[position] = marker
  end

  def print
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts line = " - - - - -"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts line
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
end

tic_tac_toe = Game.new
tic_tac_toe.play


