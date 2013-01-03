$:.push File.expand_path("../lib", __FILE__)


# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "dalli-delete-matched"
  s.platform    = Gem::Platform::RUBY
  s.version     = "1.1.0"
  s.author      = "Kourza Ivan a.k.a. Phobos98"
  s.email       = "phobos98@phobos98.net"
  s.homepage    = "https://github.com/Phobos98/dalli-delete-matched"
  s.summary     = "Rails Dalli Store extension for delete_matched support"
  s.description = %{Provides delete_matched for Dalli store in Rails 3}

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "dalli-delete-matched"

  s.files = Dir['lib/**/*.rb']
  s.require_path = 'lib'
  s.autorequire = 'builder'
  s.has_rdoc = false
  s.extra_rdoc_files = Dir['[A-Z]*']

  s.add_dependency "dalli"
end