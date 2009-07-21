require 'ostruct'
require 'yaml'

raw_config           = File.read(RAILS_ROOT + "/config/access_denied_config.yml")
config               = OpenStruct.new(YAML.load(raw_config))
::AccessDeniedConfig = OpenStruct.new(config.send("roles"))
