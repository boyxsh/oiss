class ApplicationController < ActionController::Base
  protect_from_forgery


  private
  def authenticate

    if session[:admin].blank? 
     request.env['HTTP_AUTHORIZATION'] = nil
        session[:admin] = true
    end
    authenticate_or_request_with_http_basic do |user_name, password|
      if (user_name == 'admin' && password == 'admin')
        session[:admin] = true
      else
        session[:admin] = false
      end
    end
  end
end
