require_relative "computer_code_maker"
require_relative "human_code_breaker"
require_relative "message"

class Board
  include Message

  attr_reader :code_maker, :code_breaker

  def initialize
    @code_maker = ComputerCodeMaker.new
    @code_breaker = HumanCodeBreaker.new
  end
end

# Testing
