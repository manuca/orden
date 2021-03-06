# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'orden/version'

Gem::Specification.new do |spec|
  spec.name          = "orden"
  spec.version       = Orden::VERSION
  spec.authors       = ["Manuel Barros Reyes"]
  spec.email         = ["manuca@gmail.com"]

  spec.description   = %q{A tiny helper to sort columns in Rack apps}
  spec.summary       = %q{It relies exclusively on Rack to parse and rewrite query strings so no extra dependencies are required}
  spec.homepage      = "https://github.com/manuca/orden"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rack", "~> 1.6"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3"
end
