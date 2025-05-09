require_relative "../code_breaker"
require_relative "../message"

class HumanCodeBreaker < CodeBreaker
  include Message

  def input_attempt
    loop do
      human_code_breaker_instructions_msg(game.code_maker.secret_code_range,
                                          game.code_maker.secret_code_length)
      input = gets.chomp.chars.map(&:to_i)
      return input if game.code_maker.valid_code?(input)

      invalid_entry_msg
    end
  end
end
