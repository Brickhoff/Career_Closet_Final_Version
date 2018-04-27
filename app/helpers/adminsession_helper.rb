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

  def is_super_admin?
      current_admin.superadmin == true
  end
  
  def logged_in_as_superadmin
    unless is_super_admin?
      flash[:danger] = "Please login as SuperAdmin."
      redirect_to adminlogin_path
    end
  end
  
  def logged_in_as_admin
    unless (admin_logged_in? || is_super_admin?)
      flash[:danger] = "Please login as Admin or SuperAdmin to move on."
      redirect_to adminlogin_path
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
    cookies.permanent[:admin_remember_token] = admin.admin_remember_token
  end
  
  def admin_forget(admin)
    admin.forget
    cookies.delete(:admin_id)
    cookies.delete(:admin_remember_token)
  end

  def deny_access
    redirect_to adminlogin_path, :notice => "Please sign in this admin page."
  end
  
end
