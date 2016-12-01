# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'month_year/version'

Gem::Specification.new do |spec|
  spec.name          = "month_year"
  spec.version       = MonthYear::VERSION
  spec.authors       = ["Daniel Illi"]
  spec.email         = ["daniel@illi.zone"]
  spec.summary       = %q{MonthYear represents a specific month in a specific year.}
  spec.description   = <<-DESC
A MonthYear instance represents a specific month in a specific year.
It implements comparison operations, can be used to create ranges, (de-)serializes to/from Integer and can
be used for attributes of ActiveRecord Models.
  DESC
  spec.homepage      = "https://github.com/daniel-illi/month_year"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "pry"
end
