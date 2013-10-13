# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'prettyusers/version'

Gem::Specification.new do |spec|
  spec.name          = "prettyusers"
  spec.version       = Prettyusers::VERSION
  spec.authors       = ["El Mehdi Sakout"]
  spec.email         = ["elmehdi.sakout@gmail.com"]
  spec.description   = %q{Generate pretty users for your tests}
  spec.summary       = %q{This gem allows you to generate pretty user's information with an avatar, name, password, email, gender, phone ... }
  spec.homepage      = "https://github.com/medyo/prettyusers"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
