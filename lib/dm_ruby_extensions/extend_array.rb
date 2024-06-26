# frozen_string_literal: true

#------------------------------------------------------------------------------
class Array
  # Extract options from a set of arguments. Removes and returns the last element
  # in the array if it's a hash, otherwise returns a blank hash.
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
    self.select { |item| item <= value }.max
  end

  # able to join safe and unsafe strings
  #------------------------------------------------------------------------------
  def xss_aware_join(delimiter = '')
    ''.html_safe.tap do |str|
      each_with_index do |element, i|
        str << delimiter if i.positive?
        str << element
      end
    end
  end

  # given an array of css classes/styles, join them into one string.
  # only join non-nil/non-empty strings, and return nil if the result
  # is an empty string (rails tag methods will not include the
  # attribute if it is nil, which is desirable for cleaner html)
  #------------------------------------------------------------------------------
  def css_join(_delimiter = '')
    str = flatten.delete_if { |x| x.nil? || x == '' }.join(' ')
    str == '' ? nil : str
  end
end
