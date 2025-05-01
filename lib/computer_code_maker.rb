require "colorize"

class ComputerCodeMaker
  attr_reader :secret_code_range, :secret_code_length, :secret_code,
              :feedback_format, :feedback_pegs

  def initialize
    @secret_code_range = 1..6
    @secret_code_length = 4
    @secret_code = generate_secret_code
    @feedback_format = { correct: 0, misplaced: 0, not_present: 0 }
    @feedback_pegs = { correct: "● ".colorize(:red),
                       misplaced: "● ".colorize(:white),
                       not_present: "● ".colorize(:grey) }
  end

  def generate_secret_code
    secret_code = []
    secret_code_length.times { secret_code << secret_code_range.to_a.sample }
    secret_code
  end

  def print_secret_code
    secret_code.each { |num| print "#{num} ".colorize(:red) }
    puts
  end

  def obscure_secret_code
    secret_code.each { print "? ".colorize(:red) }
    puts
  end

  def generate_feedback(guess)
    feedback = feedback_format

    guess.each_index do |i|
      if number_correct?(guess[i], secret_code[i])
        feedback[:correct] += 1
      elsif number_misplaced?(guess[i], secret_code[i])
        feedback[:misplaced] += 1
      elsif number_not_present?(guess[i])
        feedback[:not_present] += 1
      end
    end

    feedback
  end

  def number_correct?(guess_num, secret_code_num)
    guess_num == secret_code_num
  end

  def number_misplaced?(guess_num, secret_code_num)
    guess_num != secret_code_num && secret_code.include?(guess_num)
  end

  def number_not_present?(guess_num)
    true unless secret_code.include?(guess_num)
  end
end

# Testing
# my_computer_code_maker = ComputerCodeMaker.new
