require 'spec_helper'
require 'dm_ruby_extensions'

describe Fixnum do

  describe 'factorial' do
    #------------------------------------------------------------------------------
    it 'return the factorial of the number' do
      expect(5.factorial).to eq 120
      expect(1.factorial).to eq 1
    end
  end

  describe 'as_boolean' do
    specify { expect(1.as_boolean).to be_truthy }
    specify { expect(0.as_boolean).to be_falsey }
    specify { expect(20.as_boolean).to be_truthy }
  end

end