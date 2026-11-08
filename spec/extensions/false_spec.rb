# frozen_string_literal: true

require 'spec_helper'
require 'dm_ruby_extensions'

RSpec.describe FalseClass do
  describe 'as_boolean' do
    specify { expect(false.as_boolean).to be false }
  end
end
