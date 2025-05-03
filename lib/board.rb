require "pry-byebug"
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
    attempts_with_feedback.reverse_each do |hash|
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
      hash[:attempt] == code_maker.secret_code
    end
  end

  def valid_attempt?(attempt_str)
    true if attempt_str.length == code_maker.secret_code_length &&
            attempt_str.chars.all? { |char| code_maker.secret_code_range.include?(char.to_i) }
  end

  def convert_attempt_to_array(attempt_str)
    attempt_str.chars.map(&:to_i)
  end

  def update_next_attempt_row_and_inline_feedback(attempt_str) # rubocop:disable Metrics/AbcSize
    unless valid_attempt?(attempt_str)
      invalid
      return
    end
    attempt_arr = convert_attempt_to_array(attempt_str)
    feedback_arr = code_maker.generate_feedback(attempt_arr)
    attempts_with_feedback[code_breaker.attempts_made][:attempt] = attempt_arr
    attempts_with_feedback[code_breaker.attempts_made][:feedback] = feedback_arr
    code_breaker.attempts_made += 1
  end
end

# Testing
my_board = Board.new
10.times do
  my_board.print_board
  my_board.update_next_attempt_row_and_inline_feedback(my_board.code_breaker.prompt_attempt)
end
