# Changelog

## 1.6.0

- Support Ruby 4.0: `required_ruby_version` is now `>= 3.2` (was `~> 3.0`, which
  excluded Ruby 4).
- Drop support for Ruby 3.0 and 3.1, which have reached end of life.
- Limit ActiveSupport to `>= 6.0, < 9`.
- Gemspec: package files with `Dir` instead of `git ls-files`, remove the
  deprecated `test_files`, require MFA for publishing, and add source, changelog
  and bug tracker links.
- Replace the Travis build, which no longer ran, with GitHub Actions on Ruby 3.2
  through 4.0.
- Update RuboCop to 1.92 and rubocop-rspec to 3.10.
- Fix a spec for `nil + other` that didn't actually test it.

## 1.5.0

- Drop support for Ruby 2.
