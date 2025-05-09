class CodeBreaker
  def initialize(game)
    @game = game
    @attempts_available = 10
    @attempts_made = 0
  end

  attr_reader :attempts_available, :game
  attr_accessor :attempts_made

  def attempts_exhausted?
    attempts_made == attempts_available
  end

  def code_breaker_wins?
    game.board.attempts_with_feedback.any? do |hash|
      hash[:attempt] == game.code_maker.secret_code
    end
  end
end
