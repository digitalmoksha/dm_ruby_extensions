#------------------------------------------------------------------------------
class Time

  #------------------------------------------------------------------------------
  def localize(options = {})
    options = {:format => options} if options.class == String      
    I18n.localize(self, options)
  end

end

