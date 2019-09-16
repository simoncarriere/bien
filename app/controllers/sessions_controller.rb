class SessionsController < ApplicationController

  def new
    #login form
  end

  def create
    #actually try and log in
    @form_data = params.require(:session)

    #pull out username and password from form form_data
    @username = @form_data[:username]
    @password = @form_data[:password]

    #Lets authenticate the user
    @user = User.find_by(username: @username).try(:authenticate, @password)

    # if user true, create sessions, if not redirect home
    if @user
      # save this user to user session
      session[:user_id] = @user.id

      redirect_to root_path
    else
      render "new"
    end


  end

  def destroy
    #log us out
    #remove the session completely
    reset_session

    # redirect to log in page
    redirect_to new_session_path

  end



end
