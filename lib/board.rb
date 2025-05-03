require_relative "computer_code_maker"
require_relative "human_code_breaker"
require_relative "message"

class Board
  include Message

  attr_reader :code_maker, :code_breaker
  attr_accessor :attempts_with_feedback

  def initialize
    @code_maker = ComputerCodeMaker.new
    @code_breaker = HumanCodeBreaker.new
    @attempts_with_feedback = generate_initial_attempt_rows_with_inline_feedback
  end

  def generate_initial_attempt_rows_with_inline_feedback
    attempts_with_feedback = []
    code_breaker.attempts_available.times do
      attempts_with_feedback <<
        { attempt: Array.new(code_maker.secret_code_length, 0),
          feedback: Array.new(code_maker.secret_code_length,
                              code_maker.feedback_pegs[:not_present]) }
    end
    attempts_with_feedback
  end

  def print_attempt_rows_with_inline_feedback
    attempts_with_feedback.each do |hash|
      hash[:attempt].each { |digit| print "#{digit} " }
      hash[:feedback].each { |peg| print "#{peg} " }
      puts
    end
  end

  def print_board
    # game_over? ? code_maker.print_secret_code : code_maker.obscure_secret_code
    code_maker.print_secret_code # Cheating
    print_attempt_rows_with_inline_feedback
  end

  def game_over?
    code_breaker_wins? || code_breaker.attempts_exhausted?
  end

  def code_breaker_wins?
    attempts_with_feedback.any? do |hash|
      hash[:attempt] == code_breaker.secret_code
    end
  end
end

# Testing
my_board = Board.new
# my_board.print_attempt_rows_with_inline_feedback
my_board.print_board
