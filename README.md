# DmRubyExtensions

[![Gem Version](https://badge.fury.io/rb/dm_ruby_extensions.svg)](http://badge.fury.io/rb/dm_ruby_extensions)
[![Build Status](https://travis-ci.com/digitalmoksha/dm_ruby_extensions.svg?branch=master)](https://travis-ci.com/digitalmoksha/dm_ruby_extensions)

Adds some simple convenience methods to some Ruby classes, for use in the digitalMoksha gems.
Although some of these can be found in other libraries, this includes a small handful and
removes the dependency on another large library.

## Installation

Add this line to your application's Gemfile:

    gem 'dm_ruby_extensions'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dm_ruby_extensions

## Usage

#### Array

* extract_options!
* closest_max
* xss_aware_join
* css_join

#### Date

* to_age
* localize

#### DateTime

* to_age
* localize

#### Fixnum

* factorial
* as_boolean

#### Hash

* convert_date
* convert_datetime
* url_query_string
* rekey
* rekey!

#### Nil

* to_s_default
* as_boolean
* to_age
* sql_wildcard

#### Numeric

* percent_of

#### String

* to_s_default
* as_boolean
* as_css_size
* sql_wildcard
* replace_non_alphanumeric
* expand_url
* absolute_url?
* smart_titlecase
* smart_capitalize
* smart_capitalize!
* smart_truncate
* name_case
* name_case!

#### Time

* localize


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
