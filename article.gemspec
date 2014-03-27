$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "article/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "article"
  s.version     = Article::VERSION
  s.authors     = ["The guy that flips tables"]
  s.email       = ["hello@forthlight.org"]
  s.homepage    = "Forthlight.org"
  s.summary     = "ArticleEngine, it's GRAPE!."
  s.description = "TODO: Description of Article."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "4.0.3"
  s.add_dependency 'tinymce-rails'
  s.add_dependency "pg", "0.17.1"
  s.add_dependency 'mongoid', '4.0.0.beta1'
  
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "minitest", "4.7.5"
end