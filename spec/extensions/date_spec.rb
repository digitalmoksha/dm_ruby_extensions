# frozen_string_literal: true

require 'spec_helper'
require 'dm_ruby_extensions'

describe Date do
  describe 'to_age' do
    it 'return number of years since now' do
      expect(Date.new(Time.now.year - 50, Time.now.month, Time.now.day).to_age).to eq 50
    end
  end

  describe 'localize' do
    it 'localize the date based on the format' do
      I18n.enforce_available_locales = false
      I18n.locale = :en
      date = Date.new(2012, 11, 23)
      expect(date.localize).to eq '2012-11-23'
      expect(date.localize(format: :short)).to eq 'Nov 23'
      expect(date.localize('%b %Y')).to eq 'Nov 2012'
    end
  end

  describe 'to_index' do
    it 'creates unique sortable index for a date' do
      date = Date.new(2012, 11, 23)
      expect(date.to_index).to eq 12_328
    end
  end
end
