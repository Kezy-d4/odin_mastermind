require_relative "computer_code_maker"
require_relative "human_code_breaker"
require_relative "message"

class Board
  include Message

  attr_reader :code_maker, :code_breaker
  attr_accessor :code_breaker_rows

  def initialize
    @code_maker = ComputerCodeMaker.new
    @code_breaker = HumanCodeBreaker.new
    @code_breaker_rows = build_code_breaker_rows
  end

  def build_code_breaker_rows
    code_breaker_rows = []
    code_breaker.attempts_available.times do
      code_breaker_rows << Array.new(code_maker.secret_code_length, 0)
    end
    code_breaker_rows
  end

  def print_code_breaker_rows
    code_breaker_rows.reverse_each do |row|
      row.each { |digit| print "#{digit} " }
      puts
    end
  end

  def print_board
    # game_over? ? code_maker.print_secret_code : code_maker.obscure_secret_code
    code_maker.print_secret_code # Cheating
    print_code_breaker_rows
  end

  def game_over?
    code_breaker_wins? || code_breaker.attempts_exhausted?
  end

  def code_breaker_wins?
    code_breaker_rows.any?(code_maker.secret_code)
  end

  def update_next_code_breaker_row
    guess_str = code_breaker.prompt_guess
    unless valid_guess?(guess_str)
      invalid
      return
    end
    guess_arr = guess_str.chars.map(&:to_i)
    code_breaker_rows[code_breaker.attempts_made] = guess_arr
    code_breaker.attempts_made += 1
  end

  def valid_guess?(guess_str)
    guess_str.length == code_maker.secret_code_length &&
      guess_str.chars.all? { |chr| code_maker.secret_code_range.include?(chr.to_i) }
  end
end

# Testing
