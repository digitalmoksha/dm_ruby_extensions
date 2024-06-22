require 'spec_helper'
require 'dm_ruby_extensions'

describe Hash do

  describe 'convert_date' do
    #------------------------------------------------------------------------------
    it 'converts a rails date hash' do
      datehash = {'start_date(1i)' => 2012, 'start_date(2i)' => 11, 'start_date(3i)' => 23}
      expect(datehash.convert_date(:start_date)).to eq Date.new(2012, 11, 23)
      expect(datehash.convert_date(:end_date)).to eq nil
    end
  end

  describe 'convert_datetime' do
    #------------------------------------------------------------------------------
    it 'converts a rails datetime hash' do
      datehash = {'start_date(1i)' => 2012, 'start_date(2i)' => 11, 'start_date(3i)' => 23, 'start_date(4i)' => 8, 'start_date(5i)' => 35}
      expect(datehash.convert_datetime(:start_date)).to eq Time.local(2012, 11, 23, 8, 35)
      expect(datehash.convert_datetime(:end_date)).to eq nil
    end
  end

  describe 'url_query_string' do
    #------------------------------------------------------------------------------
    it 'converts hash of parameters to a query string' do
      params = {tag: 'shoe', as_admin: '1'}
      expect(params.url_query_string).to eq '/?as_admin=1&tag=shoe'
      expect(params.url_query_string(false)).to eq '?as_admin=1&tag=shoe'
    end
  end

  describe 'rekey' do
    #------------------------------------------------------------------------------
    it 'if a key map is given, then the first key is changed to the second key.' do
      foo = { :a => 1, :b => 2 }
      expect(foo.rekey(:a=>'a')).to eq({ 'a' => 1, :b => 2 })
      expect(foo.rekey(:b=>:x)).to eq({ :a => 1, :x => 2 })
      expect(foo.rekey('foo'=>'bar')).to eq({ :a => 1, :b => 2 })
    end

    #------------------------------------------------------------------------------
    it 'converts all keys in the Hash accroding to the given block procedure' do
      foo = { :name=>'Gavin', :wife=>:Lisa }
      expect(foo.rekey{ |k| k.to_s }).to eq({ "name" => "Gavin", "wife" => :Lisa })
    end

    #------------------------------------------------------------------------------
    it 'converts all keys to symbols' do
      foo = { 'name' => 'Gavin', 'wife' => :Lisa }
      expect(foo.rekey).to eq({ :name => "Gavin", :wife => :Lisa })
    end
  end

end
