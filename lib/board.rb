require "pry-byebug"

class Board
  def initialize(game)
    @game = game
    @attempts_with_feedback = generate_initial_attempt_rows_with_inline_feedback
  end

  attr_reader :game
  attr_accessor :attempts_with_feedback

  def generate_initial_attempt_rows_with_inline_feedback
    attempts_with_feedback = []
    game.code_breaker.attempts_available.times { attempts_with_feedback << blank_row }
    attempts_with_feedback
  end

  def blank_row
    row = { attempt: [], feedback: [] }
    game.code_maker.secret_code_length.times { row[:attempt] << 0 }
    game.code_maker.secret_code_length.times do
      row[:feedback] << game.code_maker.feedback_pegs[:not_present]
    end
    row
  end

  def print_attempt_rows_with_inline_feedback
    attempts_with_feedback.reverse_each do |row|
      row[:attempt].each { |digit| print "#{digit} " }
      row[:feedback].each { |peg| print "#{peg} " }
      puts
    end
  end

  def input_next_attempt_and_provide_feedback(input)
    attempts_with_feedback[game.code_breaker.attempts_made][:attempt] = input
    attempts_with_feedback[game.code_breaker.attempts_made][:feedback] =
      game.code_maker.generate_feedback(input)
    game.code_breaker.attempts_made += 1
  end

  def print_board
    game.game_over? ? game.code_maker.print_secret_code : game.code_maker.obscure_secret_code
    print_attempt_rows_with_inline_feedback
  end
end
