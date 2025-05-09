require_relative "lib/game"

class Mastermind
  def initialize
    @game = Game.new
  end

  attr_reader :game
end

mastermind = Mastermind.new
mastermind.game.play_game
