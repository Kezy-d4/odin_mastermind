require_relative "code_maker"

class Game
  attr_reader :code_maker, :secret_code

  def initialize
    @code_maker = CodeMaker.new
    @secret_code = code_maker.generate_secret_code
  end
end

puts Game.new.secret_code
