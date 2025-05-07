require_relative "lib/game"

class Mastermind
  attr_reader :game

  def initialize
    @game = Game.new
  end
end

master_mind = Mastermind.new
master_mind.game.play_game
