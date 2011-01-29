module ApplicationHelper
  def admin?
      session[:admin]
  end

  def show_goto_admin
      link_to 'Goto admin', admin_index_path
  end

  def show_logout
    link_to 'Logout', admin_logout_path 
  end
end
