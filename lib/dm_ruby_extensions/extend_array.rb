#------------------------------------------------------------------------------
class Array

  # Extract options from a set of arguments. Removes and returns the last element in the array if it's a hash, otherwise returns a blank hash.
  #
  #   def options(*args)
  #     args.extract_options!
  #   end
  #
  #   options(1, 2)           # => {}
  #   options(1, 2, :a => :b) # => {:a=>:b}
  #------------------------------------------------------------------------------
  def extract_options!
    last.is_a?(::Hash) ? pop : {}
  end

  # Return the value that is closest to the value in the array, rounded down.
  # [0,5,7,8,11,16].closest_max(6) => 5
  # [0,5,7,8,11,16].closest_max(7) => 7
  #------------------------------------------------------------------------------
  def closest_max(value)
    self.select{|item| item <= value}.max
  end

  # able to join safe and unsafe strings
  #------------------------------------------------------------------------------
  def xss_aware_join(delimiter = '')
    ''.html_safe.tap do |str|
      each_with_index do |element, i|
        str << delimiter if i > 0
        str << element
      end
    end
  end
end

