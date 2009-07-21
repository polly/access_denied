class AccessDeniedGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      # m.directory "lib"
      # m.template 'README', "README"
      m.template "add_roles_to_user_migration.rb", "db/migrate/#{generate_migration_prefix}add_roles_to_user.rb"
      m.template "access_denied_config.yml",        "config/access_denied_config.yml"
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
