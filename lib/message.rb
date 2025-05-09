module Message
  def human_code_breaker_instructions_msg(secret_code_range, secret_code_length)
    print "Submit your next #{secret_code_length} digit long guess " \
          "without any spaces and with each digit being somewhere between " \
          "#{secret_code_range.to_a.first}–" \
          "#{secret_code_range.to_a.last}: "
  end

  def welcome_msg
    puts "Welcome to a game of Mastermind! Note that duplicates " \
         "are allowed in the code. Let's play."
  end

  def invalid_entry_msg
    puts "Invalid previous entry! Try again."
  end

  def human_code_breaker_wins_msg
    puts "You cracked the code. Nice!"
  end

  def human_code_breaker_loses_msg
    puts "You failed to crack the code. Better luck next time!"
  end

  def choose_role_to_play_instructions_msg
    print "Would you like to play as the Code Maker and have the computer try " \
          "to guess your secret code, y/n?: "
  end

  def choose_secret_code_instructions_msg(secret_code_range, secret_code_length)
    print "Submit your #{secret_code_length} digit long secret code " \
          "without any spaces and with each digit being somewhere between " \
          "#{secret_code_range.to_a.first}–" \
          "#{secret_code_range.to_a.last}: "
  end

  def computer_code_breaker_wins_msg
    puts "The computer cracked your secret code!"
  end

  def computer_code_breaker_loses_msg
    puts "The computer failed to crack your secret code!"
  end

  def computer_guessing_msg
    puts "The computer is making its next guess..."
  end

  def choose_difficulty_instructions_msg
    print "Would you like to play on hard mode (wider code " \
          "range), y/n?: "
  end
end
