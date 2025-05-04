module Message
  def instructions(secret_code_range, secret_code_length)
    puts "Submit your next #{secret_code_length} digit guess " \
         "without any spaces and with each digit being somewhere between " \
         "#{secret_code_range.to_a.first}–" \
         "#{secret_code_range.to_a.last}: "
  end

  def welcome
    puts "Welcome to a game of Mastermind! Duplicates are allowed in the code. " \
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
end
