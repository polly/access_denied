module UserExtensions

  def self.included(klass)
    klass.send :include, InstanceMethods
  end

  module InstanceMethods
    access_denied_config = ::AccessDeniedConfig.methods(false).reject { |item| item.include?("=") }.sort
    access_denied_config.each do |method_name|
      define_method "#{method_name}?" do
        self.role_type == ::AccessDeniedConfig.send(method_name)
      end
    end
  end
end
