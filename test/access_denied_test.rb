require 'test_helper'

class AccessDeniedTest < ActiveSupport::TestCase
  load_schema

  class User < ActiveRecord::Base; end

  test "activerecord stuff" do
    assert_equal [], User.all
  end
end
