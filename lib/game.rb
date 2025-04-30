require_relative "computer_code_maker"
require_relative "human_code_breaker"

class Game
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
    code_maker.obscure_secret_code

    guess_rows_set.each do |guess_row|
      guess_row.each { |number| print "#{number} " }
      puts
    end
  end
end

# Testing
my_game = Game.new
my_game.guess_rows_set.each_with_index { |row, idx| p "#{idx}: #{row}" }
my_game.print_board
