# coding: utf-8
require File.expand_path("../lib/self_renderer/version", __FILE__)

Gem::Specification.new do |gem|
  gem.name        = "self_renderer"
  gem.license     = "MIT"
  gem.version     = SelfRenderer::VERSION
  gem.authors     = ["Nathan Hopkins"]
  gem.email       = ["natehop@gmail.com"]
  gem.homepage    = "https://github.com/hopsoft/self_renderer"
  gem.summary     = "Rails model & object rendering outside the context of web requests"

  gem.files       = Dir["lib/**/*.rb", "bin/*", "[A-Z]*"]
  gem.test_files  = Dir["test/**/*.rb"]

  gem.add_dependency "activesupport"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "pry-test"
  gem.add_development_dependency "coveralls"
  gem.add_development_dependency "rubocop"
end
