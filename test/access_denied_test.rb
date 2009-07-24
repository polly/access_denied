require 'test_helper'

class AccessDeniedTest < ActiveSupport::TestCase
  load_schema

  class ::User < ActiveRecord::Base; end
  
  test "that the admin? method returns true for an admin user" do
    user = User.new :role_type => 1

    assert_equal true, user.admin?
  end

  test "that the privileged_user? method returns false for an admin user" do
    class ::User < ActiveRecord::Base; set_table_name :admin_user; end
    user = User.new

    assert_equal false, user.privileged_user?
  end

  test "that the regular_user? method returns false for an admin user" do
    class ::User < ActiveRecord::Base; set_table_name :admin_user; end
    user = User.new

    assert_equal false, user.privileged_user?
  end
  
  test "that the privileged_user? method returns true for a privileged user" do
    user = User.new :role_type => 2

    assert_equal true, user.privileged_user?
  end

  test "that the admin? method returns false for a privileged user" do
    user = User.new :role_type => 2

    assert_equal false, user.admin?
  end
  
  test "that the regular_user? method returns false for a privileged user" do
    user = User.new :role_type => 2

    assert_equal false, user.regular_user?
  end
  
  test "that the regular_user? method returns true for a regular user" do
    user = User.new :role_type => 3

    assert_equal true, user.regular_user?
  end

  test "that the admin? method returns false for a regular user" do
    user = User.new :role_type => 3

    assert_equal false, user.admin?
  end

  test "that the privileged_user? method returns false for a regular user" do
    user = User.new :role_type => 3

    assert_equal false, user.privileged_user?
  end

end
