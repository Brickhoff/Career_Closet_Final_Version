module SpecTestHelper
    def admin_log_in
        @admin = FactoryGirl.create(:admin)
        session[:admin_id] = @admin.id
    end

    def user_log_in
        @user = FactoryGirl.create(:user)
        session[:user_id] = @user.id
    end

    def current_user
        if (user_id = session[:user_id])
          @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.signed[:user_id])
          user = User.find_by(id: user_id)
          if user && user.authenticated?(:remember, cookies[:remember_token])
            user_log_in user
            @current_user = user
          end
        end
    end
    
    def is_super_admin?
      current_admin.superadmin == true
    end
    
    def current_admin
      if (admin_id = session[:admin_id])
        @current_admin ||= Admin.find_by(id: admin_id)
      elsif (admin_id = cookies.signed[:admin_id])
        admin = Admin.find_by(id: admin_id)
        if admin && admin.authenticated?(cookies[:remember_token])
          admin_log_in admin
          @current_admin = admin
        end
      end
    end
end