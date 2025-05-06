module Message
  def instructions(secret_code_range, secret_code_length)
    puts "Submit your next #{secret_code_length} digit guess " \
         "without any spaces and with each digit being somewhere between " \
         "#{secret_code_range.to_a.first}–" \
         "#{secret_code_range.to_a.last}: "
  end

  def welcome
    puts "Welcome to a game of Mastermind! Note that duplicates are allowed in the code. " \
         "Let's play."
  end

  def invalid
    puts "Invalid previous entry! Try again."
  end

  def you_win
    puts "You cracked the code. Nice!"
  end

  def you_lose
    puts "You failed to crack the code. Better luck next time!"
  end

  def choose_which_role_to_play
    puts "Would you like to play as the Code Maker and have the computer try " \
         "to guess your secret code, y/n?"
  end

  def choose_your_secret_code(secret_code_range, secret_code_length)
    puts "Submit your secret code without any spaces. The code must be " \
         "#{secret_code_length} digits long with each digit being somewhere " \
         "between #{secret_code_range.to_a.first}–#{secret_code_range.to_a.last}."
  end

  def computer_wins
    puts "The computer cracked your secret code!"
  end

  def computer_lost
    puts "The computer failed to crack your secret code!"
  end

  def computer_guessing
    puts "The computer will make its next guess..."
  end
end
