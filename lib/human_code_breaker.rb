class HumanCodeBreaker
  attr_reader :attempts_available, :attempts_remaining

  def initialize
    @attempts_available = 10
    @attempts_remaining = attempts_available
  end
end
