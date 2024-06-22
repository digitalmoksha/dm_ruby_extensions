# frozen_string_literal: true

#------------------------------------------------------------------------------
class Time
  #------------------------------------------------------------------------------
  def localize(options = {})
    options = { format: options } if options.instance_of?(String)
    I18n.localize(self, **options)
  end
end
