WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

class Game
  def initialize
    @playfield = Board.new
    @player1 = Player.new('Player 1', 'X')
    @player2 = Player.new('Player 2', 'O')
    @current_player = @player1
  end

  def play
    loop do
      
    end
  end

end

class Player
  attr_accessor :player_id, :marker
  def initialize(player_id, marker)
    @player_id = player_id
    @marker = marker
  end

  def select_position

  end
end

class Board
  def initialize
    @board = Array(1..9)
  end

  def full?
    @board.all { |i| i.to_i == 0 }
  end
end

tic_tac_toe = Game.new
tic_tac_toe.play


