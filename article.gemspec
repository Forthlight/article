$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "article/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "article"
  s.version     = Article::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Article."
  s.description = "TODO: Description of Article."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.3"
  s.add_dependency 'tinymce-rails'
  s.add_dependency "pg"
  s.add_dependency 'mongoid', '4.0.0.beta1'


  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "minitest", "4.7.5"
  s.add_development_dependency 'rspec-rails', '2.14.1'
  s.add_development_dependency 'fabrication', '2.9.6'
  s.add_development_dependency "database_cleaner", "0.8.0"
  s.add_development_dependency "spork-rails", '4.0.0'
end
