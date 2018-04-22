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
end