class AccessDeniedGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      # Create directory structure
      m.directory "lib/access_denied"
      m.directory "lib/access_denied/extensions"

      # Library files:
      m.template "access_denied.rb",                     "config/initializers/access_denied.rb"
      m.template "application_controller_extensions.rb", "lib/access_denied/extensions/application_controller_extensions.rb"
      m.template "user_extensions.rb",                   "lib/access_denied/extensions/user_extensions.rb"
      m.template "add_roles_to_user_migration.rb",       "db/migrate/#{generate_migration_prefix}add_roles_to_user.rb"
      m.template "access_denied_config.yml",             "config/access_denied_config.yml"

      # Test files:
      m.template "application_controller_extensions_test.rb", "test/functional/application_controller_extensions_test.rb"
      m.template "user_extensions_test.rb", "test/unit/user_extensions_test.rb"
    end
  end

  def generate_migration_prefix
    year, month, day, hour, min, sec = DateTime.now.year, DateTime.now.month, DateTime.now.day, DateTime.now.hour, DateTime.now.min, DateTime.now.sec
    month = "0#{month}" unless month > 10
    day   = "0#{day}"   unless day   > 10
    hour  = "0#{hour}"  unless hour  > 10
    min   = "0#{min}"   unless min   > 10
    sec   = "0#{sec}"   unless sec   > 10

    "#{year}#{month}#{day}#{hour}#{min}#{sec}_"
  end
end
