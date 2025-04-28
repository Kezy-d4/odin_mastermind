require "colorize"

class CodePeg
  attr_reader :color

  @@possible_colors = %i[red green blue yellow magenta white]

  def initialize
    @color = "⬤".colorize(@@possible_colors.sample)
  end
end

# puts CodePeg.new.color
