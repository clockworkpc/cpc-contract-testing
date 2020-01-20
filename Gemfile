source "https://rubygems.org"
gemspec
gem 'facets'
gem 'faraday'
# Windows and JRuby does not include zoneinfo files, so bundle the tzinfo-data gem
# and associated library.
install_if -> { RUBY_PLATFORM =~ %r!mingw|mswin|java! } do
  gem "tzinfo", "~> 1.2"
  gem "tzinfo-data"
end

# Performance-booster for watching directories on Windows
gem "wdm", "~> 0.1.1", :install_if => Gem.win_platform?

gem 'cpc', :git => 'https://github.com/clockworkpc/cpc-ruby.git'

group :development do
  gem 'guard', require: false
  gem 'guard-rubocop'
  gem 'guard-rspec'
end
