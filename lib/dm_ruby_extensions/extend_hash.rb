# frozen_string_literal: true

#------------------------------------------------------------------------------
class Hash
  # takes a Hash (like the params hash), and converts the Rails date attributes
  # to a real Date object.
  # {'start_date(1i)' => 2012, 'start_date(2i)' => 11, 'start_date(3i)' => 23}.convert_date(:start_date)
  #------------------------------------------------------------------------------
  def convert_date(date_symbol_or_string)
    attribute = date_symbol_or_string.to_s
    return nil if self["#{attribute}(1i)"].nil? || self["#{attribute}(2i)"].nil? || self["#{attribute}(3i)"].nil?

    Date.new(self["#{attribute}(1i)"].to_i, self["#{attribute}(2i)"].to_i, self["#{attribute}(3i)"].to_i)
  end

  # takes a Hash (like the params hash), and converts the Rails datetime attributes
  # to a real Date object.
  #------------------------------------------------------------------------------
  def convert_datetime(date_symbol_or_string)
    attribute = date_symbol_or_string.to_s
    if self["#{attribute}(1i)"].nil? || self["#{attribute}(2i)"].nil? ||
       self["#{attribute}(3i)"].nil? || self["#{attribute}(4i)"].nil? ||
       self["#{attribute}(5i)"].nil?
      return nil
    end

    Time.local(self["#{attribute}(1i)"].to_i, self["#{attribute}(2i)"].to_i, self["#{attribute}(3i)"].to_i,
               self["#{attribute}(4i)"].to_i, self["#{attribute}(5i)"].to_i)
  end

  # Convert hash of parameters to a query string
  #------------------------------------------------------------------------------
  # rubocop:disable Style/OptionalBooleanParameter
  def url_query_string(leading_slash = true)
    "#{leading_slash ? '/?' : '?'}#{to_query}"
  end
  # rubocop:enable Style/OptionalBooleanParameter

  # Borrowed from https://github.com/rubyworks/facets
  #------------------------------------------------------------------------------
  # Rekey a hash:
  #
  #   rekey()
  #   rekey(from_key => to_key, ...)
  #   rekey{|from_key| to_key}
  #   rekey{|from_key, value| to_key}
  #
  # If a key map is given, then the first key is changed to the second key.
  #
  #   foo = { :a=>1, :b=>2 }
  #   foo.rekey(:a=>'a')       #=> { 'a'=>1, :b=>2 }
  #   foo.rekey(:b=>:x)        #=> { :a =>1, :x=>2 }
  #   foo.rekey('foo'=>'bar')  #=> { :a =>1, :b=>2 }
  #
  # If a block is given, converts all keys in the Hash according to the
  # given block procedure.
  #
  #   foo = { :name=>'Gavin', :wife=>:Lisa }
  #   foo.rekey{ |k| k.to_s }  #=>  { "name"=>"Gavin", "wife"=>:Lisa }
  #   foo                      #=>  { :name =>"Gavin", :wife=>:Lisa }
  #
  # If no key map or block is given, then all keys are converted
  # to Symbols.
  #
  # Raises an ArgumentError if both a +key_map+ and a block are given.
  # If both are needed just call #rekey twice.
  #
  # TODO: If `nil` is returned by block should the key be set to `nil` or the original key?
  #
  # CREDIT: Trans, Gavin Kistner
  def rekey(key_map = nil, &block)
    raise ArgumentError, 'argument or block' if key_map && block

    unless key_map || block
      block = lambda { |k| k.to_sym } # rubocop:disable Style/SymbolProc, Style/Lambda
    end

    if block
      hash = dup.clear
      if block.arity.abs == 1
        each_pair do |k, v|
          hash[block[k]] = v # hash[block[k] || k] = v
        end
      else
        each_pair do |k, v|
          hash[block[k, v]] = v # hash[block[k,v] || k] = v
        end
      end
    else
      # hash = dup.clear  # to keep default_proc
      # (keys - key_map.keys).each do |key|
      #   hash[key] = self[key]
      # end
      # key_map.each do |from, to|
      #   hash[to] = self[from] if key?(from)
      # end
      hash = dup # to keep default_proc
      key_map.each_pair do |from, to|
        hash[to] = hash.delete(from) if hash.key?(from)
      end
    end

    hash
  end

  # Synonym for Hash#rekey, but modifies the receiver in place (and returns it).
  #
  #   foo = { :name=>'Gavin', :wife=>:Lisa }
  #   foo.rekey!{ |k| k.to_s }  #=>  { "name"=>"Gavin", "wife"=>:Lisa }
  #   foo                       #=>  { "name"=>"Gavin", "wife"=>:Lisa }
  #
  # CREDIT: Trans, Gavin Kistner

  def rekey!(key_map = nil, &block)
    replace(rekey(key_map, &block))
  end
end
