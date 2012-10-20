#------------------------------------------------------------------------------
class Hash
  
  # takes a Hash (like the params hash), and converts the Rails date attributes 
  # to a real Date object.
  #------------------------------------------------------------------------------
  def convert_date(date_symbol_or_string)
    attribute = date_symbol_or_string.to_s
    return Date.new(self[attribute + '(1i)'].to_i, self[attribute + '(2i)'].to_i, self[attribute + '(3i)'].to_i)   
  end

  # takes a Hash (like the params hash), and converts the Rails datetime attributes 
  # to a real Date object.
  #------------------------------------------------------------------------------
  def convert_datetime(date_symbol_or_string)
    attribute = date_symbol_or_string.to_s
    return Time.local(self[attribute + '(1i)'].to_i, self[attribute + '(2i)'].to_i, self[attribute + '(3i)'].to_i, self[attribute + '(4i)'].to_i, self[attribute + '(5i)'].to_i)   
  end

end
