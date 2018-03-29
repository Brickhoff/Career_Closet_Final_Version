module AdminsessionHelper
  
  def admin_log_in(admin)
    session[:admin_id] = admin.id
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
  
  def admin_logged_in?
    !current_admin.nil?
  end
  
  def admin_log_out
    admin_forget(current_admin)
    session.delete(:admin_id)
    @current_user = nil
  end
  
  def admin_remember(admin)
    admin.remember
    cookies.permanent.signed[:admin_id] = admin.id
    cookies.permanent[:remember_token] = admin.remember_token
  end
  
  def admin_forget(admin)
    admin.forget
    cookies.delete(:admin_id)
    cookies.delete(:remember_token)
  end

  def deny_access
    redirect_to adminlogin_path, :notice => "Please sign in this admin page."
  end
end
