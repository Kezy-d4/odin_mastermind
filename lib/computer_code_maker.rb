require "colorize"

class ComputerCodeMaker
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
    feedback_arr = []
    correct_digits(attempt_arr).times { feedback_arr << feedback_pegs[:correct] }
    feedback_arr
  end

  def correct_digits(attempt_arr)
    amount = 0
    attempt_arr.each_index do |idx|
      amount += 1 if attempt_arr[idx] == secret_code[idx]
    end
    amount
  end

  def digits_remaining_to_evaluate(feedback_arr)
    secret_code_length - feedback_arr.length
  end

  def positions_of_correct_digits(attempt_arr)
    attempt_arr.each_index.select { |idx| attempt_arr[idx] == secret_code[idx] }
  end
end

# Testing
