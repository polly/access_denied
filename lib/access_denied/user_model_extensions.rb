module UserModelExtensions
  AccessDeniedConfig.methods(false).each do |method_name|
    unless method_name.include? "="
      define_method "#{method_name}?" do
        self.role_type == AccessDeniedConfig.send("#{method_name}")
      end
    end
  end
end

class User < ActiveRecord::Base
  include UserModelExtensions
end
