require 'spec_helper'
require 'dm_ruby_extensions'

describe TrueClass do

  describe 'as_boolean' do
    specify { expect(true.as_boolean).to eq true }
  end
  

end