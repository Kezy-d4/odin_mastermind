class HumanCodeBreaker
  attr_reader :attempts_available
  attr_accessor :attempts_made

  def initialize
    @attempts_available = 10
    @attempts_made = 0
  end

  def prompt_attempt
    puts "Your guess?"
    gets.chomp
  end

  def attempts_exhausted?
    attempts_made == attempts_available
  end
end

# Testing
