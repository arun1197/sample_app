class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
    	# Log the user in and redirect to the user's show page.
    	log_in user # sets session
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      # remember user -> sets cookies and updates db
    	redirect_back_or user
    else
    	# Create an error message
    	flash.now[:danger] = 'Invalid email/password combination'
    	# flash message persists one request longer than we want
    	# use flash.now instead
    	render 'new'
    end
  end

  def destroy
  	#deletes cookies and session, makes remember_digest nil
    log_out if logged_in?
  	redirect_to root_url
  end

end
