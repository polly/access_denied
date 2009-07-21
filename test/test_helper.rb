require 'rubygems'
require 'active_support'
require 'active_support/test_case'
require 'ostruct'
require 'yaml'

class AccessDeniedConfig
  class << self
    attr_accessor :admin, :privileged_user, :regular_user
  end
end

AccessDeniedConfig.admin           = 1
AccessDeniedConfig.privileged_user = 2
AccessDeniedConfig.regular_user    = 3
