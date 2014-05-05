# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'aceitafacil/version'

Gem::Specification.new do |spec|
  spec.name          = "aceitafacil"
  spec.version       = Aceitafacil::VERSION
  spec.authors       = ["Wilbert Ribeiro"]
  spec.email         = ["wkelyson@gmail.com"]
  spec.summary       = %q{ This gem enables Aceita Fácil API features on Ruby on Rails }
  spec.description   = %q{ It implements Cards and Payments from Aceita Fácil doc spec. }
  spec.homepage      = "http://www.github.com/wilbert/aceitafacil"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "json", "1.8.1"

  spec.add_development_dependency "bundler",              "~> 1.5"
  spec.add_development_dependency "rake",                 "10.3.1"
  spec.add_development_dependency "rspec-rails",          "2.14.2"
  spec.add_development_dependency "fakeweb",              "1.3.0"
  spec.add_development_dependency "factory_girl_rails",   "4.4.0"
  spec.add_development_dependency "debugger",             "1.6.6"
end
