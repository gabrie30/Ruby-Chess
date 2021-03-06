require_relative 'bishop'
require_relative 'jumping_pieces'
require_relative 'king'
require_relative 'knight'
require_relative 'pawn'
require_relative 'piece'
require_relative 'queen'
require_relative 'rook'
require_relative 'sliding_pieces'
require_relative 'board'
require_relative 'graphic'

class Game
  attr_accessor :board

  def initialize(board, graphic)
    @board = board
    @graphic = graphic
    @teams = [:Black, :White]
    @colors_turn = turn?
  end

  def run
    until checkmate?
      begin
      from, to = @graphic.get_inputs(@colors_turn)
      @board.move(from, to, @colors_turn)
      rescue MoveError
      retry
      end
      @colors_turn = turn?
      @graphic.display
    end
    puts "GAME OVER CHECKMATE"
  end

  def checkmate?
    @board.in_check?(@colors_turn) && @board.cant_get_out_of_check?(@colors_turn)
  end

  def turn?
    @teams.rotate!
    @teams[0]
  end
end

class MoveError < StandardError
end

board = Board.new(8)
graphic = Graphic.new(board)

game = Game.new(board, graphic)
game.run