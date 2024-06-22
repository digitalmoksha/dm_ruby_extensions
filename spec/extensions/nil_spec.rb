# frozen_string_literal: true

require 'spec_helper'
require 'dm_ruby_extensions'

describe NilClass do
  describe 'to_s_default' do
    it 'returns default string' do
      expect(nil.to_s_default).to eq 'n/a'
      expect(nil.to_s_default('--')).to eq '--'
    end
  end

  describe 'as_boolean' do
    specify { expect(nil.as_boolean).to eq false }
  end

  describe 'to_age' do
    specify { expect(nil.to_age).to eq 0 }
  end

  describe 'sql_wildcard' do
    specify { expect(nil.sql_wildcard).to eq '%' }
  end

  describe 'utc' do
    specify { expect(nil.utc).to eq '' }
  end

  describe '+(y)' do
    specify { expect(nil + 12).to eq 12 }
    specify { expect('foo').to eq 'foo' }
  end
end
