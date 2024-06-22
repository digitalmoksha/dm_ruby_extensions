# frozen_string_literal: true

class Integer
  # Factorial of number
  # 5.factorial == 5 x 4 x 3 x 2 x 1 == 120
  #------------------------------------------------------------------------------
  def factorial
    return 1 if zero?

    (1..self).inject(:*)
  end

  #------------------------------------------------------------------------------
  def as_boolean
    positive? ? true : false
  end
end
