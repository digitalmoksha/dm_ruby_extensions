# frozen_string_literal: true

require 'spec_helper'
require 'dm_ruby_extensions'

RSpec.describe TrueClass do
  describe 'as_boolean' do
    specify { expect(true.as_boolean).to be true }
  end
end
