class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by( email: params[:session][:email_or_name].downcase ) || User.find_by( name: params[:session][:email_or_name] )
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)
        wednesday_string = " YEEY, it is #{view_context.link_to( "Wednesday", "http://isitwednesdaymydudes.ml")}, my dude!!!"
        flash[:success] = "Welcome back #{user.name}!" + (wednesday_string if Date.today.wday == 3).to_s
        redirect_back_or user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
         else
      flash.now[:danger] = 'Invalid email or username / password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
