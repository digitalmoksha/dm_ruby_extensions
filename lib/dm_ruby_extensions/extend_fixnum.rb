class Fixnum
  
  #------------------------------------------------------------------------------
  def factorial
    return 1 if self.zero?
    (1..self).inject(:*)
  end
  
end