require 'test_helper'

class UserExtensionsTest < ActiveSupport::TestCase
  access_denied_config = ::AccessDeniedConfig.methods(false).reject { |item| item.include?("=") }.sort

  access_denied_config.each do |method_name|
    define_method "test_#{method_name}_for_#{method_name}_should_return_true" do
      user = User.new
      user.role_type = AccessDeniedConfig.send(method_name)

      assert_equal true, user.send("#{method_name}?")
    end

    access_denied_config.reject { |item| item == method_name }.each do |name|
        define_method "test_#{name}_for_#{method_name}_should_return_false" do
          user = User.new
          user.role_type = AccessDeniedConfig.send(method_name)

          assert_equal false, user.send("#{name}?")
        end
      end
  end
end
