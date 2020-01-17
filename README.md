# CPC Ruby Gem Template

This is a template for a personal Ruby gem project that is boosted by the Classes and Modules in `cpc-ruby` on Github.

## Getting Started

1. Edit and rename `contractor.gemspec` according to your needs.
1. Execute the customised script `bin/setup`.

This will do the following:
1. Clone `git@github.com:clockworkpc/cpc-ruby.git` into `tmp`
1. Copy selected RSpec unit tests from `tmp/cpc-ruby/spec/cpc/` into `spec/cpc/`
1. Overwrite `Guardfile` with `tmp/cpc-ruby/Guardfile` 

In this way you will be able to ascertain that your project has indeed inherited CPC-Ruby Classes and Modules.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).
