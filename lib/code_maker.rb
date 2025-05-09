require "colorize"

class CodeMaker
  def initialize(game)
    @game = game
    @secret_code_length = 4
    @secret_code_range = game.human_code_breaker_hard_mode ? 1..8 : 1..6
    @feedback_pegs = { correct: "●".colorize(:red),
                       misplaced: "●".colorize(:white),
                       not_present: "●".colorize(:grey) }
  end

  attr_reader :secret_code_length, :secret_code_range, :feedback_pegs, :game

  def valid_code?(input)
    input.length == secret_code_length &&
      input.all? { |char| secret_code_range.include?(char) }
  end

  def print_secret_code
    secret_code.each { |digit| print "#{digit} ".colorize(:red) }
    puts
  end

  def obscure_secret_code
    secret_code.each { print "? ".colorize(:red) }
    puts
  end

  def generate_feedback(input)
    feedback_format = evaluate_feedback(input)
    feedback_arr = []
    feedback_format[:correct].times { feedback_arr << feedback_pegs[:correct] }
    feedback_format[:misplaced].times { feedback_arr << feedback_pegs[:misplaced] }
    feedback_format[:not_present].times { feedback_arr << feedback_pegs[:not_present] }
    feedback_arr
  end

  def evaluate_feedback(input)
    feedback_format = { correct: 0, misplaced: 0, not_present: 0 }
    input_copy = input.dup
    secret_code_copy = game.code_maker.secret_code.dup
    count_correct_digits(input_copy, secret_code_copy, feedback_format)
    count_remaining_digits_misplaced(input_copy, secret_code_copy, feedback_format)
    count_remaining_digits_not_present(secret_code_copy, feedback_format)
    feedback_format
  end

  def count_correct_digits(input, secret_code, feedback_format)
    input.each_index do |idx|
      next unless input[idx] == secret_code[idx]

      input[idx] = nil
      secret_code[idx] = nil
      feedback_format[:correct] += 1
    end
  end

  def count_remaining_digits_misplaced(input, secret_code, feedback_format)
    input.each_index do |idx|
      next unless secret_code.include?(input[idx]) && !input[idx].nil?

      input_misplaced_digit = input[idx]
      secret_code_misplaced_digit_idx = secret_code.index(input_misplaced_digit)
      input[idx] = nil
      secret_code[secret_code_misplaced_digit_idx] = nil
      feedback_format[:misplaced] += 1
    end
  end

  def count_remaining_digits_not_present(input, feedback_format)
    return if input.all?(nil)

    remaining_digits_not_present = input.count { |digit| !digit.nil? }
    remaining_digits_not_present.times { feedback_format[:not_present] += 1 }
  end
end
