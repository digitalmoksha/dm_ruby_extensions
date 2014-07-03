# If the string is empty, then return a default string
#------------------------------------------------------------------------------
class String  #:nodoc:

  # If the string is empty, return a default value, otherwise the string
  #------------------------------------------------------------------------------
  def to_s_default(default_str = 'n/a')
    (empty? || strip.empty?) ? default_str : self.to_s
  end
  
  #------------------------------------------------------------------------------
  def as_boolean
    (self == 'true' || self == 'yes' || self == '1' || self == 1) ? true : false
  end

  # given a css type of size (like a width), make it into a valid css value
  #------------------------------------------------------------------------------
  def as_css_size
    size = self
    size += 'px' unless size.blank? || size.end_with?('px', '%', 'em') || size == 'auto' || size == 'inherit'
    return size
  end

  # Adds SQL wildcard cahracters to begin/end of string for use in LIKE statements
  #------------------------------------------------------------------------------
  def sql_wildcard
    "%#{self}%"	  
  end
  
  # Replace non-alphanumbic character
  #------------------------------------------------------------------------------
  def replace_non_alphanumeric(replacement = '')
    self.gsub /[^\w\.\-]/, replacement
  end
  
  # Santize the string
  #   Note: File.basename doesn't work right with Windows paths on Unix
  #------------------------------------------------------------------------------
  def sanitize_filename
    name = self.strip
    #--- get only the filename, not the whole path
    name.gsub! /^.*(\\|\/)/, ''
    
    #--- Finally, replace all non alphanumeric, underscore or periods with underscore
    name.gsub! /[^\w\.\-]/, '_'
    return name
  end

  # if a relative url path is given, then expand it by prepending the supplied 
  # path.
  #------------------------------------------------------------------------------
  def expand_url(path = '')
    if self.blank? || self.absolute_url?
      return self
    else
      return path + self
    end
  end

  # Test if a url is absolute
  #------------------------------------------------------------------------------
  def absolute_url?
    (self.include?('://') || self.start_with?('/')) ? true : false
  end

  #------------------------------------------------------------------------------

  # Ruby version of John Gruber's TitleCase.pl, from http://github.com/samsouder/titlecase
  # Used for better capitalizing titles and sentences
  #------------------------------------------------------------------------------
  def smart_titlecase
    small_words = %w(a an and as at but by en for if in of on or the to v v. via vs vs. von)
    
    x = split(" ").map do |word|
      # note: word could contain non-word characters!
      # downcase all small_words, capitalize the rest
      small_words.include?(word.gsub(/\W/, "").downcase) ? word.downcase! : word.smart_capitalize!
      word
    end
    # capitalize first and last words
    x.first.smart_capitalize!
    x.last.smart_capitalize!
    # small words after colons are capitalized
    x.join(" ").gsub(/:\s?(\W*#{small_words.join("|")}\W*)\s/) { ": #{$1.smart_capitalize} " }
  end
  
  #------------------------------------------------------------------------------
  def smart_capitalize
    # ignore any leading crazy characters and capitalize the first real character
    if self =~ /^['"\(\[']*([a-z])/
      i = index($1)
      x = self[i,self.length]
      # word with capitals and periods mid-word are left alone
      self[i,1] = self[i,1].upcase unless x =~ /[A-Z]/ or x =~ /\.\w+/
    end
    self
  end
  
  #------------------------------------------------------------------------------
  def smart_capitalize!
    replace(smart_capitalize)
  end

  # Truncate the string to a set or words, or sentences.
  # string.smart_truncate(:sentences => 3)
  # string.smart_truncate(:words => 12)
  # From http://stackoverflow.com/questions/1293573/rails-smart-text-truncation
  #------------------------------------------------------------------------------
  def smart_truncate(opts = {})
    opts = {:words => 12}.merge(opts)
    if opts[:sentences]
      return self.split(/\.(\s|$)+/).reject{ |s| s.strip.empty? }[0, opts[:sentences]].map{|s| s.strip}.join('. ') + '...'
    end
    a = self.split(/\s/) # or /[ ]+/ to only split on spaces
    n = opts[:words]
    a[0...n].join(' ') + (a.size > n ? '...' : '')    
  end
  #------------------------------------------------------------------------------
  
  # http://github.com/tenderlove/namecase
  # NameCase is a Ruby implementation of Lingua::EN::NameCase, a library for
  # converting strings/names to be properly cased. This is good for converting
  # denormalized data to human friendly data.
  #------------------------------------------------------------------------------
  def name_case
    localstring = downcase
    localstring.gsub!(/\b\w/) { |first| first.upcase }
    localstring.gsub!(/\'\w\b/) { |c| c.downcase } # Lowercase 's    

    if localstring =~ /\bMac[A-Za-z]{2,}[^aciozj]\b/ or localstring =~ /\bMc/
      localstring.gsub!(/\b(Ma?c)([A-Za-z]+)/) { |match| $1 + $2.capitalize }

      # Now fix "Mac" exceptions
      localstring.gsub!(/\bMacEvicius/, 'Macevicius')
      localstring.gsub!(/\bMacHado/, 'Machado')
      localstring.gsub!(/\bMacHar/, 'Machar')
      localstring.gsub!(/\bMacHin/, 'Machin')
      localstring.gsub!(/\bMacHlin/, 'Machlin')
      localstring.gsub!(/\bMacIas/, 'Macias')
      localstring.gsub!(/\bMacIulis/, 'Maciulis')
      localstring.gsub!(/\bMacKie/, 'Mackie')
      localstring.gsub!(/\bMacKle/, 'Mackle')
      localstring.gsub!(/\bMacKlin/, 'Macklin')
      localstring.gsub!(/\bMacQuarie/, 'Macquarie')
    end
    localstring.gsub!('Macmurdo','MacMurdo')

    # Fixes for "son (daughter) of" etc
    localstring.gsub!(/\bAl(?=\s+\w)/, 'al')  # al Arabic or forename Al.
    localstring.gsub!(/\bAp\b/, 'ap')         # ap Welsh.
    localstring.gsub!(/\bBen(?=\s+\w)/,'ben') # ben Hebrew or forename Ben.
    localstring.gsub!(/\bDell([ae])\b/,'dell\1')  # della and delle Italian.
    localstring.gsub!(/\bD([aeiu])\b/,'d\1')   # da, de, di Italian; du French.
    localstring.gsub!(/\bDe([lr])\b/,'de\1')   # del Italian; der Dutch/Flemish.
    localstring.gsub!(/\bEl\b/,'el')   # el Greek or El Spanish.
    localstring.gsub!(/\bLa\b/,'la')   # la French or La Spanish.
    localstring.gsub!(/\bL([eo])\b/,'l\1')      # lo Italian; le French.
    localstring.gsub!(/\bVan(?=\s+\w)/,'van')  # van German or forename Van.
    localstring.gsub!(/\bVon\b/,'von')  # von Dutch/Flemish

    # Fix roman numeral names
    localstring.gsub!(
      / \b ( (?: [Xx]{1,3} | [Xx][Ll]   | [Ll][Xx]{0,3} )?
             (?: [Ii]{1,3} | [Ii][VvXx] | [Vv][Ii]{0,3} )? ) \b /x
    ) { |match| match.upcase }

    localstring
  end
  
  # Modifies _str_ in place and properly namecases the string.
  #------------------------------------------------------------------------------
  def name_case!
    self.gsub!(self, self.name_case)
  end
  
end

