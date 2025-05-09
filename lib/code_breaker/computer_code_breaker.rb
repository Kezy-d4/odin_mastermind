require_relative "../code_breaker"
require_relative "../message"

# The intelligent computer Code Breaker algorithm is only functional assuming
# traditional game rules; that is, ten attempts available, a code range of six
# possible digits, and a code length of four digits. If any of these
# parameters are adjusted, the game will still work, but the computer Code
# Breaker will guess randomly without considering the feedback in any way or
# employing any systematic strategy.
class ComputerCodeBreaker < CodeBreaker
  include Message

  def initialize(game)
    super
    @digits_present = []
    @possible_codes_already_guessed = []
  end

  attr_reader :digits_present, :possible_codes_already_guessed

  def generate_attempt
    computer_guessing_msg
    sleep(3)
    return generate_random_attempt unless game.all_default_game_parameters?

    return generate_one_of_first_five_attempts if attempts_made < 5

    evaluate_first_five_attempts_to_determine_digits_present if attempts_made == 5
    generate_remaining_possible_code
  end

  def generate_random_attempt
    arr = []
    game.code_maker.secret_code_length.times do
      arr << game.code_maker.secret_code_range.to_a.sample
    end
    arr
  end

  def generate_one_of_first_five_attempts
    return if attempts_made >= 5

    arr = []
    game.code_maker.secret_code_length.times { arr << attempts_made.next }
    arr
  end

  def evaluate_first_five_attempts_to_determine_digits_present
    (1..attempts_made).to_a.each_with_index do |digit, idx|
      attempt_to_evaluate = game.board.attempts_with_feedback[idx][:attempt]
      feedback = game.code_maker.evaluate_feedback(attempt_to_evaluate)
      feedback[:correct].times { digits_present << digit }
    end
    add_any_remaining_sixes(digits_present)
  end

  def add_any_remaining_sixes(digits_present)
    remaining_sixes = game.code_maker.secret_code_length - digits_present.length
    remaining_sixes.times { digits_present << 6 }
  end

  def generate_remaining_possible_code
    loop do
      possible_code = digits_present.shuffle
      next if possible_codes_already_guessed.include?(possible_code)

      possible_codes_already_guessed << possible_code
      return possible_code
    end
  end
end
