require_relative "code_peg"

class CodeMaker
  def generate_secret_code
    secret_code = []
    4.times { secret_code << CodePeg.new.color }
    secret_code
  end
end

# puts CodeMaker.new.create_secret_code
