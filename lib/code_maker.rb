require_relative "code_peg"

class CodeMaker
  attr_reader :secret_code

  def initialize(secret_code_length = 4)
    @secret_code = CodePeg.generate_secret_code(secret_code_length)
  end

  def display_secret_code
    secret_code.each { |number| print number }
    puts
  end
end

CodeMaker.new.display_secret_code
