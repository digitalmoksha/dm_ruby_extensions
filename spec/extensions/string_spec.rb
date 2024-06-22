# frozen_string_literal: true

require 'spec_helper'
require 'dm_ruby_extensions'

describe String do
  describe 'to_s_default' do
    specify { expect('foobar'.to_s_default).to eq 'foobar' }
    specify { expect(''.to_s_default).to eq 'n/a' }
    specify { expect(''.to_s_default('--')).to eq '--' }
  end

  describe 'as_boolean' do
    specify { expect('true'.as_boolean).to be_truthy }
    specify { expect('yes'.as_boolean).to be_truthy }
    specify { expect('1'.as_boolean).to be_truthy }
    specify { expect('false'.as_boolean).to be_falsey }
    specify { expect('foo'.as_boolean).to be_falsey }
  end

  describe 'as_css_size' do
    specify { expect('50'.as_css_size).to eq '50px' }
    specify { expect(''.as_css_size).to eq '' }
    specify { expect('50px'.as_css_size).to eq '50px' }
    specify { expect('50%'.as_css_size).to eq '50%' }
    specify { expect('50em'.as_css_size).to eq '50em' }
    specify { expect('auto'.as_css_size).to eq 'auto' }
    specify { expect('inherit'.as_css_size).to eq 'inherit' }
  end

  describe 'sql_wildcard' do
    specify { expect('foobar'.sql_wildcard).to eq '%foobar%' }
  end

  describe 'replace_non_alphanumeric' do
    specify { expect('fo9o^()b  ar'.replace_non_alphanumeric).to eq 'fo9obar' }
    specify { expect('fo9o^()b  ar'.replace_non_alphanumeric('*')).to eq 'fo9o***b**ar' }
  end

  describe 'sanitize_filename' do
    specify { expect('foobar.doc'.sanitize_filename).to eq 'foobar.doc' }
    specify { expect('/user/home/foobar.doc'.sanitize_filename).to eq 'foobar.doc' }
    specify { expect('/user/home/f9o o(b+a^r.d*c'.sanitize_filename).to eq 'f9o_o_b_a_r.d_c' }
  end

  describe 'expand_url' do
    specify { expect('/home/foobar.doc'.expand_url).to eq '/home/foobar.doc' }
    specify { expect('/foobar.doc'.expand_url('/home/')).to eq '/foobar.doc' }
    specify { expect('foobar.doc'.expand_url).to eq '/foobar.doc' }
    specify { expect('foobar.doc'.expand_url('/home/')).to eq '/home/foobar.doc' }
    specify { expect('foobar.doc'.expand_url('/home')).to eq '/home/foobar.doc' }
  end

  describe 'absolute_url?' do
    specify { expect('/home/foo'.absolute_url?).to be_truthy }
    specify { expect('://home/foo'.absolute_url?).to be_truthy }
    specify { expect('home/foo'.absolute_url?).to be_falsey }
  end

  describe 'smart_titlecase' do
    specify do
      expect('a sample title and text: a treatsie'.smart_titlecase).to eq 'A Sample Title and Text: A Treatsie'
    end
  end

  describe 'smart_capitalize' do
    specify { expect('foobar'.smart_capitalize).to eq 'Foobar' }
    specify { expect('fooBar'.smart_capitalize).to eq 'fooBar' }
    specify { expect('(foobar)'.smart_capitalize).to eq '(Foobar)' }
  end

  describe 'smart_truncate' do
    specify do
      expect('One time. Two times. 3 times. 4 times.'.smart_truncate(sentences: 3))
        .to eq 'One time. Two times. 3 times...'
    end
    specify do
      expect('one two three and four five six and seven and yet another eight'.smart_truncate(words: 6))
        .to eq 'one two three and four five...'
    end
    specify do
      expect('one two three and four five six and seven and yet another eight'.smart_truncate)
        .to eq 'one two three and four five six and seven and yet another...'
    end
  end

  describe 'name_case' do
    before :each do
      @proper_names = [
        'Keith',            'Leigh-Williams',       'McCarthy',
        "O'Callaghan",      'St. John',             'von Streit',
        'van Dyke',         'Van',                  'ap Llwyd Dafydd',
        'al Fahd',          'Al',
        'el Grecco',
        'ben Gurion', 'Ben',
        'da Vinci',
        'di Caprio',        'du Pont',              'de Legate',
        'del Crond',        'der Sind',             'van der Post',
        'von Trapp',        'la Poisson',           'le Figaro',
        'Mack Knife',       'Dougal MacDonald',
        # Mac exceptions
        'Machin',           'Machlin',              'Machar',
        'Mackle',           'Macklin',              'Mackie',
        'Macquarie',        'Machado',              'Macevicius',
        'Maciulis',         'Macias',               'MacMurdo',
        # Roman numerals
        'Henry VIII',       'Louis III',            'Louis XIV',
        'Charles II',       'Fred XLIX'
      ]
    end

    it 'handles each proper name' do
      @proper_names.each do |name|
        expect(name.downcase.name_case).to eq name
        expect(name.name_case).to eq name
        # assert_equal(name, NameCase(name))
      end
    end

    it 'handles multibyte' do
      proper_cased = 'Iñtërnâtiônàlizætiøn'
      expect(proper_cased.downcase.name_case).to eq proper_cased
    end
  end
end
