class Date

  # http://stackoverflow.com/questions/819263/get-persons-age-in-ruby
  #------------------------------------------------------------------------------
  def to_age
    now = Time.now.utc.to_date
    now.year - self.year - ((now.month > self.month || (now.month == self.month && now.day >= self.day)) ? 0 : 1)
  end

  #------------------------------------------------------------------------------
  def localize(options = {})
    options = {:format => options} if options.class == String
    I18n.localize(self, **options)
  end

  # Create a unique sortable index for this date
  #------------------------------------------------------------------------------
  def to_index
    yday + (year-2000) * 1000
  end

end

