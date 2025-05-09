require_relative "../code_maker"

class ComputerCodeMaker < CodeMaker
  def initialize(game)
    super
    @secret_code = randomly_generate_secret_code
  end

  attr_reader :secret_code

  def randomly_generate_secret_code
    arr = []
    secret_code_length.times { arr << secret_code_range.to_a.sample }
    arr
  end
end
