# frozen_string_literal: true

# If the string is empty, then return a default string
#------------------------------------------------------------------------------
class String # :nodoc:
  # If the string is empty, return a default value, otherwise the string
  #------------------------------------------------------------------------------
  def to_s_default(default_str = 'n/a')
    empty? || strip.empty? ? default_str : to_s
  end

  #------------------------------------------------------------------------------
  def as_boolean
    self == 'true' || self == 'yes' || self == '1' ? true : false
  end

  # given a css type of size (like a width), make it into a valid css value
  #------------------------------------------------------------------------------
  def as_css_size
    size = self
    size += 'px' unless size.blank? || size.end_with?('px', '%', 'em') || size == 'auto' || size == 'inherit'
    size
  end

  # Adds SQL wildcard cahracters to begin/end of string for use in LIKE statements
  #------------------------------------------------------------------------------
  def sql_wildcard
    "%#{self}%"
  end

  # Replace non-alphanumbic character
  #------------------------------------------------------------------------------
  def replace_non_alphanumeric(replacement = '')
    gsub(/[^\w.-]/, replacement)
  end

  # Santize the string
  #   Note: File.basename doesn't work right with Windows paths on Unix
  #------------------------------------------------------------------------------
  def sanitize_filename
    name = strip
    #--- get only the filename, not the whole path
    name.gsub!(%r{^.*(\\|/)}, '')

    #--- Finally, replace all non alphanumeric, underscore or periods with underscore
    name.gsub!(/[^\w.-]/, '_')
    name
  end

  # if a relative url path is given, then expand it by prepending the supplied
  # path.
  #------------------------------------------------------------------------------
  def expand_url(path = '')
    return self if blank? || absolute_url?

    path.end_with?('/') ? "#{path}#{self}" : "#{path}/#{self}"
  end

  # Test if a url is absolute
  #------------------------------------------------------------------------------
  def absolute_url?
    include?('://') || start_with?('/') ? true : false
  end

  #------------------------------------------------------------------------------

  # Ruby version of John Gruber's TitleCase.pl, from http://github.com/samsouder/titlecase
  # Used for better capitalizing titles and sentences
  #------------------------------------------------------------------------------
  def smart_titlecase
    small_words = %w[a an and as at but by en for if in of on or the to v v. via vs vs. von]

    x = split(' ').map do |word|
      # NOTE: word could contain non-word characters!
      # downcase all small_words, capitalize the rest
      small_words.include?(word.gsub(/\W/, '').downcase) ? word.downcase! : word.smart_capitalize!
      word
    end
    # capitalize first and last words
    x.first.smart_capitalize!
    x.last.smart_capitalize!
    # small words after colons are capitalized
    x.join(' ').gsub(/:\s?(\W*#{small_words.join('|')}\W*)\s/) { ": #{::Regexp.last_match(1).smart_capitalize} " }
  end

  #------------------------------------------------------------------------------
  def smart_capitalize
    result = dup

    # ignore any leading crazy characters and capitalize the first real character
    return result unless self =~ /^['"(\[']*([a-z])/

    i = index(::Regexp.last_match(1))
    x = result[i, result.length]

    # word with capitals and periods mid-word are left alone
    result[i, 1] = result[i, 1].upcase unless x =~ (/[A-Z]/) || x =~ (/\.\w+/)

    result
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
    opts = { words: 12 }.merge(opts)
    if opts[:sentences]
      result = split(/\.(\s|$)+/).reject { |s| s.strip.empty? }[0, opts[:sentences]]
      return "#{result.map(&:strip).join('. ')}..."
    end

    a = split(/\s/) # or /[ ]+/ to only split on spaces
    n = opts[:words]
    a[0...n].join(' ') + (a.size > n ? '...' : '')
  end
  #------------------------------------------------------------------------------

  # http://github.com/tenderlove/namecase
  # NameCase is a Ruby implementation of Lingua::EN::NameCase, a library for
  # converting strings/names to be properly cased. This is good for converting
  # denormalized data to human friendly data.
  #------------------------------------------------------------------------------
  def name_case(options = {})
    options = { lazy: true, irish: true }.merge options

    # Skip if string is mixed case
    if options[:lazy]
      first_letter_lower = self[0] == downcase[0]
      all_lower_or_upper = downcase == self || upcase == self

      return self unless first_letter_lower || all_lower_or_upper
    end

    localstring = downcase
    localstring.gsub!(/\b\w/, &:upcase)
    localstring.gsub!(/'\w\b/, &:downcase) # Lowercase 's

    if options[:irish]
      if localstring =~ (/\bMac[A-Za-z]{2,}[^aciozj]\b/) || localstring =~ (/\bMc/)
        match = localstring.match(/\b(Ma?c)([A-Za-z]+)/)
        localstring.gsub!(/\bMa?c[A-Za-z]+/) { match[1] + match[2].capitalize }

        # Now fix "Mac" exceptions
        localstring.gsub!(/\bMacEdo/, 'Macedo')
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
        localstring.gsub!(/\bMacKmin/, 'Mackmin')
        localstring.gsub!(/\bMacQuarie/, 'Macquarie')
      end
      localstring.gsub!('Macmurdo', 'MacMurdo')
    end

    # Fixes for "son (daughter) of" etc
    localstring.gsub!(/\bAl(?=\s+\w)/, 'al')  # al Arabic or forename Al.
    localstring.gsub!(/\bAp\b/, 'ap')         # ap Welsh.
    localstring.gsub!(/\bBen(?=\s+\w)/, 'ben') # ben Hebrew or forename Ben.
    localstring.gsub!(/\bDell([ae])\b/, 'dell\1') # della and delle Italian.
    localstring.gsub!(/\bD([aeiou])\b/, 'd\1') # da, de, di Italian; du French; do Brasil
    localstring.gsub!(/\bD([ao]s)\b/, 'd\1') # das, dos Brasileiros
    localstring.gsub!(/\bDe([lr])\b/, 'de\1') # del Italian; der Dutch/Flemish.
    localstring.gsub!(/\bEl\b/, 'el')   # el Greek or El Spanish.
    localstring.gsub!(/\bLa\b/, 'la')   # la French or La Spanish.
    localstring.gsub!(/\bL([eo])\b/, 'l\1') # lo Italian; le French.
    localstring.gsub!(/\bVan(?=\s+\w)/, 'van') # van German or forename Van.
    localstring.gsub!(/\bVon\b/, 'von') # von Dutch/Flemish

    # Fix roman numeral names
    localstring.gsub!(
      / \b ( (?: [Xx]{1,3} | [Xx][Ll]   | [Ll][Xx]{0,3} )?
             (?: [Ii]{1,3} | [Ii][VvXx] | [Vv][Ii]{0,3} )? ) \b /x, &:upcase
    )

    localstring
  end

  # Modifies _str_ in place and properly namecases the string.
  #------------------------------------------------------------------------------
  def name_case!
    gsub!(self, name_case)
  end
end
