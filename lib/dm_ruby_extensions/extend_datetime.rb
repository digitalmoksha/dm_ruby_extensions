# frozen_string_literal: true

#------------------------------------------------------------------------------
class DateTime
  #------------------------------------------------------------------------------
  def to_age
    (DateTime.now - self).to_i / 365
  end

  #------------------------------------------------------------------------------
  def localize(options = {})
    options = { format: options } if options.instance_of?(String)
    I18n.localize(self, **options)
  end

  # Create a unique sortable index for this date
  #------------------------------------------------------------------------------
  def to_index
    yday + (year - 2000) * 1000
  end
end
