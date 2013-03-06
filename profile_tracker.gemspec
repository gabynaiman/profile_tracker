# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'profile_tracker/version'

Gem::Specification.new do |gem|
  gem.name          = 'profile_tracker'
  gem.version       = ProfileTracker::VERSION
  gem.authors       = ['Gabriel Naiman']
  gem.email         = ['gabynaiman@gmail.com']
  gem.description   = 'Easy way to profile ruby objects'
  gem.summary       = 'Easy way to profile ruby objects'
  gem.homepage      = 'https://github.com/gabynaiman/profile_tracker'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rspec'
end
