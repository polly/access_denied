# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{access_denied}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Patrik Hedman"]
  s.date = %q{2009-07-03}
  s.description = %q{Generators for adding simple authorization to nifty-autentication}
  s.email = %q{patrik@moresale.se}
  s.files = [
     "MIT-LICENSE",
     "README",
     "access_denied.gemspec",
     "generators/access_denied/access_denied_generator.rb",
     "generators/access_denied/templates/access_denied.rb",
     "generators/access_denied/templates/access_denied_config.yml",
     "generators/access_denied/templates/add_roles_to_user_migration.rb",
     "generators/access_denied/templates/application_controller_extensions.rb",
     "generators/access_denied/templates/application_controller_extensions_test.rb",
     "generators/access_denied/templates/user_extensions.rb",
     "generators/access_denied/templates/user_extensions_test.rb",
     "generators/access_denied/USAGE"
  ]
  s.homepage = %q{http://github.com/polly/access_denied}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{Need to write one}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
