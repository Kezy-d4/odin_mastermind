require "pry-byebug"
require "colorize"
require_relative "board"
require_relative "message"
require_relative "code_maker"
require_relative "code_maker/computer_code_maker"
require_relative "code_maker/human_code_maker"
require_relative "code_breaker"
require_relative "code_breaker/computer_code_breaker"
require_relative "code_breaker/human_code_breaker"

class Game
  include Message

  attr_reader :board, :code_maker, :code_breaker

  def initialize
    welcome
    choose_which_role_to_play
    choice = play_as_code_maker?
    @code_maker = choice ? HumanCodeMaker.new : ComputerCodeMaker.new
    @code_breaker = choice ? ComputerCodeBreaker.new : HumanCodeBreaker.new
    @board = Board.new(code_maker, code_breaker)
  end

  def play_game
    if code_breaker.instance_of?(HumanCodeBreaker)
      human_code_breaker_game_loop until board.game_over?
    else
      computer_code_breaker_game_loop until board.game_over?
    end
    if code_breaker.instance_of?(HumanCodeBreaker)
      board.code_breaker_wins? ? you_win : you_lose
    else
      board.code_breaker_wins? ? computer_wins : computer_lost
    end
    board.print_board
  end

  def human_code_breaker_game_loop
    instructions(board.code_maker.secret_code_range, board.code_maker.secret_code_length)
    board.print_board
    board.update_next_attempt_row_and_inline_feedback(board.code_breaker.prompt_attempt)
  end

  def computer_code_breaker_game_loop
    computer_guessing
    board.print_board
    sleep(3)
    board.update_next_attempt_row_and_inline_feedback(computer_guess_randomly)
  end

  def play_as_code_maker?
    choice = gets.chomp.downcase
    !%w[n no].include?(choice)
  end

  def computer_guess_randomly
    str = ""
    code_maker.secret_code_length.times { str << code_maker.secret_code_range.to_a.sample.to_s }
    str
  end
end

# Testing
my_game = Game.new
my_game.play_game
