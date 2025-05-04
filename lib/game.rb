require "colorize"
require_relative "board"
require_relative "message"

class Game
  include Message

  attr_reader :board

  def initialize
    @board = Board.new
  end

  def play_game
    welcome
    game_loop until board.game_over?
    board.code_breaker_wins? ? you_win : you_lose
    board.print_board
  end

  def game_loop
    instructions(board.code_maker.secret_code_range, board.code_maker.secret_code_length)
    board.print_board
    board.update_next_attempt_row_and_inline_feedback(board.code_breaker.prompt_attempt)
  end
end

# Testing
my_game = Game.new
my_game.play_game
