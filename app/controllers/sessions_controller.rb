class SessionsController < ApplicationController
  def login
		u = params["user"]
		user = User.authenticate u["username"], u["password"]
		if user
			session[:user_id] = user.id
		else
			reset_session
			flash[:error] = "Login failed, please try again."
		end

		redirect_to :controller => "courses", :action => "index"
  end

  def logout
		reset_session
		redirect_to :controller => "courses", :action => "index"
  end

end
