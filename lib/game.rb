require "pry-byebug"
require_relative "code_maker"
require_relative "code_maker/human_code_maker"
require_relative "code_maker/computer_code_maker"
require_relative "code_breaker"
require_relative "code_breaker/human_code_breaker"
require_relative "code_breaker/computer_code_breaker"
require_relative "board"
require_relative "message"

class Game
  include Message

  def initialize
    welcome_msg
    @human_code_maker = play_as_code_maker?
    @human_code_breaker_hard_mode = human_code_maker ? false : play_hard_mode?
    @code_maker = human_code_maker ? HumanCodeMaker.new(self) : ComputerCodeMaker.new(self)
    @code_breaker = human_code_maker ? ComputerCodeBreaker.new(self) : HumanCodeBreaker.new(self)
    @board = Board.new(self)
  end

  attr_reader :code_maker, :code_breaker, :board, :human_code_maker,
              :human_code_breaker_hard_mode

  def play_hard_mode?
    choose_difficulty_instructions_msg
    input = gets.chomp.downcase
    %w[y yes].include?(input)
  end

  def play_as_code_maker?
    choose_role_to_play_instructions_msg
    input = gets.chomp.downcase
    %w[y yes].include?(input)
  end

  def play_game
    puts human_code_maker ? computer_code_breaker_game_loop : human_code_breaker_game_loop
  end

  def human_code_breaker_game_loop
    until game_over?
      board.print_board
      board.input_next_attempt_and_provide_feedback(code_breaker.input_attempt)
    end
    board.print_board
    if code_breaker.code_breaker_wins?
      human_code_breaker_wins_msg
    else
      human_code_breaker_loses_msg
    end
  end

  def computer_code_breaker_game_loop
    until game_over?
      board.print_board
      board.input_next_attempt_and_provide_feedback(code_breaker.generate_attempt)
    end
    board.print_board
    if code_breaker.code_breaker_wins?
      computer_code_breaker_wins_msg
    else
      computer_code_breaker_loses_msg
    end
  end

  def game_over?
    code_breaker.code_breaker_wins? || code_breaker.attempts_exhausted?
  end

  def all_default_game_parameters?
    code_breaker.attempts_available == 10 &&
      code_maker.secret_code_length == 4 &&
      code_maker.secret_code_range == (1..6)
  end
end
