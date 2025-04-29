class ComputerCodeMaker
  attr_reader :secret_code_range, :secret_code_length, :secret_code

  def initialize
    @secret_code_range = (1..6)
    @secret_code_length = 4
    @secret_code = generate_secret_code
  end

  def generate_secret_code
    secret_code = []
    secret_code_length.times { secret_code << secret_code_range.to_a.sample }
    secret_code
  end

  def print_secret_code
    secret_code.each { |number| print "#{number} " }
    puts
  end

  def obscure_secret_code
    secret_code.each { print "? " }
    puts
  end
end

# Testing
my_computer_code_maker = ComputerCodeMaker.new
p my_computer_code_maker.secret_code
my_computer_code_maker.obscure_secret_code
my_computer_code_maker.print_secret_code
