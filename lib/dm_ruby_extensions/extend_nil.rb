# If nil, then return a default string
#------------------------------------------------------------------------------
class NilClass #:nodoc:
  def to_s_default(default_str = 'n/a')
    default_str
  end
  
  def to_age
    0
  end

  def sql_wildcard
    "%"	  
  end
  
  def utc
    ""
  end
  
  # if nil + something, just return something
  #------------------------------------------------------------------------------
  def +(y)
    y
  end

end