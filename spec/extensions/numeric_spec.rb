require 'spec_helper'
require 'dm_ruby_extensions'

describe Numeric do

  describe 'percent_of' do
    it 'returns percentage of number' do
      expect(25.percent_of(100)).to eq 25
      expect(25.percent_of(80)).to eq 31
      expect(25.percent_of(80, 2)).to eq 31.25
    end
  end

end