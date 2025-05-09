require_relative "../code_maker"
require_relative "../message"

class HumanCodeMaker < CodeMaker
  include Message

  def initialize(game)
    super
    @secret_code = input_secret_code
  end

  attr_reader :secret_code

  def input_secret_code
    loop do
      choose_secret_code_instructions_msg(secret_code_range, secret_code_length)
      input = gets.chomp.chars.map(&:to_i)
      return input if valid_code?(input)

      invalid_entry_msg
    end
  end
end
