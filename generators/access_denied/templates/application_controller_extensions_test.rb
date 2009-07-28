require 'test_helper'

class ApplicationControllerExtensionsTest < ActionController::TestCase
  test "unprotected actions should render just fine" do
    
    class ::UnprotectedIndexController < ApplicationController
      access_denied_config = ::AccessDeniedConfig.methods(false).reject { |item| item.include?("=") }.sort 
      ensure_role access_denied_config.first, :except => [ :index ]
      
      def index 
        render :text => "Unprotected#index"
      end
    end
    @controller = ::UnprotectedIndexController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    ActionController::Routing::Routes.draw do |map|
      map.resources :unprotected_index
    end
    
    get :index
    assert_response 200
  end

  test "protected actions should result in a redirect" do
    class ::ProtectedIndexController < ApplicationController
      access_denied_config = ::AccessDeniedConfig.methods(false).reject { |item| item.include?("=") }.sort 
      ensure_role access_denied_config.first, :only => [ :index ]
      
      def index 
        render :text => "Protected#index"
      end
    end
    @controller = ::ProtectedIndexController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    ActionController::Routing::Routes.draw do |map|
      map.resources :protected_index
    end
    
    get :index
    assert_redirected_to login_path
  end

  test "user with required role should see protected actions" do
    class ::IndexForAdminController < ApplicationController
      access_denied_config = ::AccessDeniedConfig.methods(false).reject { |item| item.include?("=") }.sort 
      ensure_role access_denied_config.first, :only => [ :index ]
      
      def index
        render :text => "Protected#show"
      end
    end
    @controller = ::IndexForAdminController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    ActionController::Routing::Routes.draw do |map|
      map.resources :index_for_admin
    end
    
    access_denied_config = ::AccessDeniedConfig.methods(false).reject { |item| item.include?("=") }.sort 
    user = User.new(:username => "test_user", :role_type => ::AccessDeniedConfig.send(access_denied_config.first), :email => "test@user.com", :password => "secret", :password_confirmation => "secret")
    user.save
    
    @request.session[:user_id] = user.id

    get :index
    assert_response :success
  end

  test "user without required role should not see protected actions" do
    class ::IndexForNonAdminController < ApplicationController
      access_denied_config = ::AccessDeniedConfig.methods(false).reject { |item| item.include?("=") }.sort 
      ensure_role access_denied_config.first, :only => [ :index ]
      
      def index
        render :text => "Protected#show"
      end
    end
    @controller = ::IndexForNonAdminController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    ActionController::Routing::Routes.draw do |map|
      map.resources :index_for_non_admin
    end
    
    access_denied_config = ::AccessDeniedConfig.methods(false).reject { |item| item.include?("=") }.sort 
    user = User.new(:username => "test_user", :role_type => AccessDeniedConfig.send(access_denied_config.last), :email => "test@user.com", :password => "secret", :password_confirmation => "secret")
    user.save
    
    @request.session[:user_id] = user.id

    get :index
    assert_redirected_to login_url
  end
end
