$:.push File.expand_path("../lib", __FILE__)


# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "dalli-delete-matched"
  s.version     = "0.9.0"
  s.authors     = ["Kourza Ivan a.k.a. Phobos98"]
  s.email       = ["phobos98@phobos98.net"]
  s.homepage    = "https://github.com/phobos981/dalli-delete-matched"
  s.summary     = ""
  s.description = ""

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "dalli"

end
