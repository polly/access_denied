require 'ostruct'
require 'yaml'

raw_config           = File.read(RAILS_ROOT + "/config/access_denied_config.yml")
config               = OpenStruct.new(YAML.load(raw_config))
::AccessDeniedConfig = OpenStruct.new(config.send("roles"))

require "#{RAILS_ROOT}/lib/access_denied/extensions/user_extensions"
require "#{RAILS_ROOT}/lib/access_denied/extensions/application_controller_extensions"
