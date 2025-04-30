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

  def build_guess_rows
    number_of_rows_to_build = code_breaker.attempts_available
    guess_rows_set = []

    number_of_rows_to_build.times do
      guess_rows_set << Array.new(code_maker.secret_code_length, 0)
    end

    guess_rows_set
  end

  def print_board
    instructions(code_maker.secret_code_range, code_maker.secret_code_length)

    if code_breaker.attempts_made < code_breaker.attempts_available
      code_maker.obscure_secret_code
    else
      code_maker.print_secret_code
    end

    guess_rows_set.reverse_each do |guess_row|
      guess_row.each { |number| print "#{number} " }
      puts
    end
  end

  def update_board(guess)
    guess = guess.chars.map(&:to_i)
    guess_rows_set[code_breaker.attempts_made] = guess
    code_breaker.attempts_made += 1
  end
end

# Testing
my_game = Game.new
# my_game.guess_rows_set.each_with_index { |row, idx| p "#{idx}: #{row}" }
until my_game.code_breaker.attempts_made == my_game.code_breaker.attempts_available
  my_game.update_board(my_game.code_breaker.prompt_guess)
  my_game.print_board
end
