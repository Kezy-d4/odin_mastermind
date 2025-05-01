require_relative "computer_code_maker"
require_relative "human_code_breaker"
require_relative "message"

class Game
  include Message

  attr_reader :code_maker, :code_breaker, :guess_rows_set

  def initialize
    @code_maker = ComputerCodeMaker.new
    @code_breaker = HumanCodeBreaker.new
    @guess_rows_set = build_guess_rows
  end

  def play_game
    game_loop until game_over?
    code_maker.print_secret_code
    print_guess_rows
    winner? ? you_win : you_lose
  end

  def game_loop
    instructions(code_maker.secret_code_range, code_maker.secret_code_length)
    code_maker.obscure_secret_code
    print_guess_rows
    update_next_guess(code_breaker.prompt_guess)
  end

  def game_over?
    attempts_exhausted? || winner?
  end

  def attempts_exhausted?
    code_breaker.attempts_made == code_breaker.attempts_available
  end

  def winner?
    guess_rows_set.any?(code_maker.secret_code)
  end

  def build_guess_rows
    number_of_rows_to_build = code_breaker.attempts_available
    guess_rows_set = []
    number_of_rows_to_build.times do
      guess_rows_set << Array.new(code_maker.secret_code_length, 0)
    end
    guess_rows_set
  end

  def print_guess_rows
    guess_rows_set.reverse_each do |guess_row|
      guess_row.each { |number| print "#{number} " }
      puts
    end
  end

  def update_next_guess(guess)
    guess = guess.chars.map(&:to_i)
    guess_rows_set[code_breaker.attempts_made] = guess
    code_breaker.attempts_made += 1
  end
end

# Testing
Game.new.play_game
