class HumanCodeBreaker
  attr_reader :attempts_available
  attr_accessor :attempts_made

  def initialize
    @attempts_available = 10
    @attempts_made = 0
  end

  def prompt_guess
    puts "Your guess?"
    gets.chomp
  end
end

# Testing
# my_human = HumanCodeBreaker.new
# p my_human.prompt_guess
