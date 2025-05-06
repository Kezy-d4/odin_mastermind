require_relative "../code_maker"
require_relative "../message"

class HumanCodeMaker < CodeMaker
  include Message

  def generate_secret_code
    secret_code = ""
    loop do
      choose_your_secret_code(secret_code_range, secret_code_length)
      secret_code = prompt_code_choice
      if valid_code_choice?(secret_code)
        secret_code = process_code_to_arr(secret_code)
        break
      end

      invalid
    end
    secret_code
  end

  def prompt_code_choice
    puts "What will be your code choice?"
    gets.chomp
  end

  def valid_code_choice?(code)
    code.length == secret_code_length && code.chars.all? { |char| secret_code_range.include?(char.to_i) }
  end

  def process_code_to_arr(code)
    code.chars.map(&:to_i)
  end
end
