# DmRubyExtensions

[![Gem Version](https://badge.fury.io/rb/dm_ruby_extensions.svg)](http://badge.fury.io/rb/dm_ruby_extensions)
[![Build status](https://github.com/digitalmoksha/dm_ruby_extensions/actions/workflows/ci.yml/badge.svg?branch=master)](https://github.com/digitalmoksha/dm_ruby_extensions/actions/workflows/ci.yml)

A small set of convenience methods added to Ruby's core classes (`String`, `Hash`,
`Array`, `Date` and others). It's used by the digitalMoksha gems, such as
[moksha_cms](https://gitlab.com/moksha_cms/moksha_cms), for formatting names and
titles, building CSS and URLs, reading Rails date params, and similar everyday jobs.

## Requirements

- Ruby 3.0 or later (CI covers 3.0 through 4.0)
- ActiveSupport 6.0 or later

Requiring the gem also loads `active_support/core_ext`. The `localize` methods use
`I18n`, which comes with ActiveSupport.

## Installation

Add it to your Gemfile:

```ruby
gem 'dm_ruby_extensions'
```

and run `bundle install`. In a Rails app it's loaded by Bundler; elsewhere, add
`require 'dm_ruby_extensions'`.

## What it adds

### String

| Method | Description |
|---|---|
| `to_s_default(default = 'n/a')` | The string, or `default` if it's empty or only whitespace |
| `as_boolean` | `true` for `'true'`, `'yes'` or `'1'`, otherwise `false` |
| `as_css_size` | Adds `px` unless the value already has `px`, `%` or `em`, or is `auto`/`inherit` |
| `sql_wildcard` | Wraps the string in `%` for a SQL `LIKE` |
| `replace_non_alphanumeric(replacement = '')` | Replaces everything except letters, digits, `_`, `.` and `-` |
| `sanitize_filename` | Strips any path (Unix or Windows) and replaces unsafe characters with `_` |
| `expand_url(path = '')` | Prefixes a relative URL with `path`; absolute URLs are returned unchanged |
| `absolute_url?` | `true` if the string contains `://` or starts with `/` |
| `smart_titlecase` | Title case that keeps small words lowercase (Ruby port of John Gruber's TitleCase) |
| `smart_capitalize` / `smart_capitalize!` | Capitalizes the first real letter, leaving words like `iPhone` alone |
| `smart_truncate(words: 12)` / `smart_truncate(sentences: n)` | Truncates by words or sentences and appends `...` |
| `name_case` / `name_case!` | Properly cases names, e.g. `McDonald`, `O'Brien` (port of Lingua::EN::NameCase) |

```ruby
'300'.as_css_size                            #=> "300px"
'images/logo.png'.expand_url('/assets')      #=> "/assets/images/logo.png"
'C:\docs\my report.pdf'.sanitize_filename    #=> "my_report.pdf"
'the lord of the rings'.smart_titlecase      #=> "The Lord of the Rings"
'one two three four five'.smart_truncate(words: 3)  #=> "one two three..."
'MCDONALD'.name_case                         #=> "McDonald"
```

### Hash

| Method | Description |
|---|---|
| `convert_date(attribute)` | Builds a `Date` from Rails date-select params (`attr(1i)`–`attr(3i)`), or `nil` |
| `convert_datetime(attribute)` | Builds a local `Time` from Rails datetime-select params (`attr(1i)`–`attr(5i)`), or `nil` |
| `url_query_string(leading_slash = true)` | Turns the hash into a query string, e.g. `"/?page=2&q=yoga"` |
| `rekey` / `rekey!` | Renames keys with a key map or a block; with neither, symbolizes all keys (from [Facets](https://github.com/rubyworks/facets)) |

```ruby
params = { 'start_date(1i)' => '2026', 'start_date(2i)' => '11', 'start_date(3i)' => '8' }
params.convert_date(:start_date)   #=> Sun, 08 Nov 2026
{ page: 2, q: 'yoga' }.url_query_string   #=> "/?page=2&q=yoga"
{ a: 1, b: 2 }.rekey(a: 'x')       # 'x' => 1, :b => 2
```

### Array

| Method | Description |
|---|---|
| `extract_options!` | Removes and returns a trailing options hash, or `{}` |
| `closest_max(value)` | The largest element that is less than or equal to `value` |
| `xss_aware_join(delimiter = '')` | Joins into an `html_safe` string, escaping elements that aren't already safe |
| `css_join` | Joins CSS class names, skipping `nil` and empty strings; returns `nil` if nothing is left, so Rails leaves the attribute out |

```ruby
[0, 5, 7, 8, 11, 16].closest_max(6)          #=> 5
['btn', nil, '', 'btn-primary'].css_join     #=> "btn btn-primary"
[nil, ''].css_join                           #=> nil
```

### Date, DateTime and Time

| Method | Description |
|---|---|
| `Date#to_age`, `DateTime#to_age` | Age in whole years, e.g. from a birth date |
| `Date#to_index`, `DateTime#to_index` | A sortable integer for the day: day of year + (year − 2000) × 1000 |
| `localize(options = {})` | `I18n.localize(self, ...)`; a string argument is taken as the `format` |

### Numbers and booleans

| Method | Description |
|---|---|
| `Integer#factorial` | `5.factorial #=> 120` |
| `Integer#as_boolean` | `true` for positive numbers, otherwise `false` |
| `Numeric#percent_of(total, precision = 0)` | `25.percent_of(80) #=> 31`; returns `0` when `total` is zero |
| `TrueClass#as_boolean`, `FalseClass#as_boolean` | Return themselves, so `as_boolean` works on any of these values |

### nil

`nil` gets the same helpers, so you don't have to check for it first:

| Method | Returns |
|---|---|
| `to_s_default(default = 'n/a')` | `default` |
| `as_boolean` | `false` |
| `to_age` | `0` |
| `sql_wildcard` | `'%'` (matches everything) |
| `utc` | `''` |
| `+(other)` | `other`, so `nil + 5 #=> 5` |

## Development

```
bundle install
bundle exec rspec
bundle exec rubocop
```

CI runs the specs on Ruby 3.0 through 4.0 (plus ruby-head) on Linux and macOS, and
runs RuboCop, for every pull request and push to `master`.

To release a new version, update `lib/dm_ruby_extensions/version.rb`, then:

```
gem build dm_ruby_extensions.gemspec
gem push dm_ruby_extensions-<version>.gem
```

## Contributing

Bug reports and pull requests are welcome at
<https://github.com/digitalmoksha/dm_ruby_extensions>. Please include specs for any
change.

## License

MIT. See [LICENSE](LICENSE).
