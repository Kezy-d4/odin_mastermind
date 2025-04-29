require_relative "code_maker"
require_relative "code_breaker"

class Game
  def initialize
    @code_maker = CodeMaker.new
    @code_breaker = CodeBreaker.new
  end
end
