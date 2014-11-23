require 'spec_helper'
require 'dm_ruby_extensions'

describe Time do

  describe 'localize' do
    it 'localize the date based on the format' do
      I18n.enforce_available_locales = false
      I18n.locale = :en
      time = Time.parse("2012-11-23 08:35 utc")
      expect(time.localize).to eq 'Fri, 23 Nov 2012 08:35:00 +0000'
      expect(time.localize(format: :short)).to eq '23 Nov 08:35'
      expect(time.localize('%b %Y')).to eq 'Nov 2012'
    end
  end
end