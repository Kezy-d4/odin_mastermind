module Message
  def instructions(secret_code_range, secret_code_length)
    puts "Submit your next #{secret_code_length} digit guess " \
         "with each digit being somewhere between " \
         "#{secret_code_range.to_a.first}–" \
         "#{secret_code_range.to_a.last}: "
  end

  def invalid
    puts "Invalid entry! Try again."
  end
end
