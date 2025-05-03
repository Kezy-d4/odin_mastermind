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
end

# Testing
