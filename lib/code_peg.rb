class CodePeg
  attr_reader :number

  @@numbers = [1, 2, 3, 4, 5, 6]

  def initialize
    @number = @@numbers.sample
  end

  def self.generate_secret_code(length)
    secret_code = []
    length.times { secret_code << CodePeg.new.number }
    secret_code
  end
end
