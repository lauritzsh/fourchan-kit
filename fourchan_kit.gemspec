# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fourchan_kit/version'

Gem::Specification.new do |spec|
  spec.name          = "fourchan_kit"
  spec.version       = FourchanKit::VERSION
  spec.authors       = ["lauritzsh"]
  spec.email         = ["mail@lauritz.me"]
  spec.summary       = %q{A tool and API wrapper for the 4chan API.}
  spec.description   = %q{Fourchan Kit is a Ruby wrapper and tool for the 4chan API. Use Fourchan Kit to interact with the API using Ruby, or use the tool to interact with the threads on 4chan.}
  spec.homepage      = "http://rubygems.org/gems/fourchan_kit"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr", "~> 2.9"
  spec.add_development_dependency "webmock", "~> 1.17"
end
