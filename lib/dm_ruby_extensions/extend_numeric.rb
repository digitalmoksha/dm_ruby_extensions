class Numeric
  #------------------------------------------------------------------------------
  def percent_of(n, precision = 0)
    n == 0 ? 0 : (self.to_f / n.to_f * 100.0).round(precision)
  end
end
