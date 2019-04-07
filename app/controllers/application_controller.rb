class ApplicationController < ActionController::Base
  # helper Chat::Engine.helpers
	before_action :configure_permitted_parameters, if: :devise_controller?
	# protect_from_forgery with: exception
	# before_action :configure_devise_parameters, if: :devise_controller?

	# def configure_devise_parameters
	# 	devise_parameter_sanitizer.permit(:sign_up){|u| u.permit(:username, :email, :password, :password_confirmation)}
	# end
	#config.time_zone = 'castern Time (US & Canada)'
	#config.active_record.default_timezone = :utc # or :local

	  protected

	  def configure_permitted_parameters
	    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
	    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
	    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
	  end


end
