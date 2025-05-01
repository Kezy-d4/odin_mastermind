module Message
  def instructions(secret_code_range, secret_code_length)
    puts "Submit your next #{secret_code_length} digit guess " \
         "with each digit being somewhere between " \
         "#{secret_code_range.to_a.first}–" \
         "#{secret_code_range.to_a.last}: "
  end

  def you_win
    puts "You win!"
  end

  def you_lose
    puts "You failed to crack the code. Better luck next time!"
  end
end
