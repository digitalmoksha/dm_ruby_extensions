# frozen_string_literal: true

class Numeric
  #------------------------------------------------------------------------------
  def percent_of(num, precision = 0)
    num.zero? ? 0 : (to_f / num * 100.0).round(precision)
  end
end
