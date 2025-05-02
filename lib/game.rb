require "colorize"
require_relative "board"
require_relative "message"

class Game
  include Message

  attr_reader :board

  def initialize
    @board = Board.new
  end
end

# Testing
