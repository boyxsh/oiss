module ApplicationHelper
  def admin?
      p session[:admin]
      session[:admin]
  end
  def show_logout
    link_to 'Logout', admin_logout_path 
  end
end
