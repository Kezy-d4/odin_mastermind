require "colorize"

class CodeMaker
  attr_reader :secret_code_range, :secret_code_length, :secret_code,
              :feedback_pegs

  def initialize
    @secret_code_range = 1..6
    @secret_code_length = 4
    @secret_code = generate_secret_code
    @feedback_pegs = { correct: "●".colorize(:red),
                       misplaced: "●".colorize(:white),
                       not_present: "●".colorize(:grey) }
  end

  def generate_secret_code
    secret_code = []
    secret_code_length.times { secret_code << secret_code_range.to_a.sample }
    secret_code
  end

  def print_secret_code
    secret_code.each { |digit| print "#{digit} ".colorize(:red) }
    puts
  end

  def obscure_secret_code
    secret_code.each { print "? ".colorize(:red) }
    puts
  end

  def generate_feedback(attempt_arr)
    feedback_format = evaluate_feedback(attempt_arr)
    feedback_arr = []
    feedback_format[:correct].times { feedback_arr << feedback_pegs[:correct] }
    feedback_format[:misplaced].times { feedback_arr << feedback_pegs[:misplaced] }
    feedback_format[:not_present].times { feedback_arr << feedback_pegs[:not_present] }
    feedback_arr
  end

  def evaluate_feedback(attempt_arr)
    feedback_format = { correct: 0, misplaced: 0, not_present: 0 }
    code_arr_copy = secret_code.dup
    attempt_arr_copy = attempt_arr.dup
    count_correct_digits(attempt_arr_copy, code_arr_copy, feedback_format)
    count_digits_misplaced(attempt_arr_copy, code_arr_copy, feedback_format)
    count_remaining_digits_not_present(attempt_arr_copy, feedback_format)
    feedback_format
  end

  def count_correct_digits(attempt_arr, code_arr, feedback_format)
    attempt_arr.each_index do |idx|
      next unless attempt_arr[idx] == code_arr[idx]

      attempt_arr[idx] = nil
      code_arr[idx] = nil
      feedback_format[:correct] += 1
    end
  end

  def count_digits_misplaced(attempt_arr, code_arr, feedback_format)
    attempt_arr.each_index do |idx|
      next unless code_arr.include?(attempt_arr[idx]) && !attempt_arr[idx].nil?

      attempt_misplaced_digit = attempt_arr[idx]
      code_misplaced_digit_idx = code_arr.index(attempt_misplaced_digit)
      attempt_arr[idx] = nil
      code_arr[code_misplaced_digit_idx] = nil
      feedback_format[:misplaced] += 1
    end
  end

  def count_remaining_digits_not_present(attempt_arr, feedback_format)
    return if attempt_arr.all?(nil)

    remaining_digits_not_present = attempt_arr.count { |digit| !digit.nil? }
    remaining_digits_not_present.times { feedback_format[:not_present] += 1 }
  end
end

# Testing
