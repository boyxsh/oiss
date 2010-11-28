class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def authenticate
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == 'admin' && password == 'admin'
    end
  end
end
