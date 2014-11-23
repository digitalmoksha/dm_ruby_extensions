require 'spec_helper'
require 'dm_ruby_extensions'

describe Array do

  describe 'closest_max' do
    #------------------------------------------------------------------------------
    it 'return the value that is closest to the value in the array, rounded down' do
      expect([0,5,7,8,11,16].closest_max(6)).to eq 5
      expect([0,5,7,8,11,16].closest_max(7)).to eq 7
    end
  end

  describe 'extract_options!' do
    #------------------------------------------------------------------------------
    it "Removes and returns the last element in the array if it's a hash, otherwise returns a blank hash" do
      args = [1, 2, {:a => :b}]
      expect(args.extract_options!).to eq ({:a => :b})
      expect(args).to eq [1, 2]
      expect(args.extract_options!).to eq ({})
    end
  end
  
  describe 'xss_aware_join' do
    it 'safely join safe and unsafe strings' do
      safe    = "<p>Safe</p>".html_safe
      unsafe  = "<script></script>"
      expect([safe, unsafe].xss_aware_join).to eq "<p>Safe</p>&lt;script&gt;&lt;/script&gt;"
      expect([safe, unsafe].xss_aware_join.class).to eq ActiveSupport::SafeBuffer
    end
  end
  
  describe 'css_join' do
    it 'given an array of css classes/styles, join them into one string' do
      classes = ['panel', '', 'panel-body', nil, 'red']
      expect(classes.css_join(' ')).to eq 'panel panel-body red'
    end
  end
end