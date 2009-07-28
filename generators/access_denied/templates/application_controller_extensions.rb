module Authorizer
  def self.included(controller)
    controller.send :include, InstanceMethods
    controller.extend ClassMethods
  end

  module InstanceMethods
    def authorized?(*roles)
      if current_user
        unless valid_user?(*roles)
          session[:user_id] = nil
          login_required
        end
      else
        login_required
      end
    end

    def valid_user?(*roles)
      statement = returning [] do |s|
        roles.each { |role| s << current_user.send("#{role}?") }
      end.join(" || ")

      return eval(statement)
    end
  end

  module ClassMethods
    def ensure_role(*args)
      actions, roles = args.extract_options!, args
      before_filter(actions) { |c| c.authorized? *roles }
    end
  end
end

ActionController::Base.send(:include, Authorizer)
