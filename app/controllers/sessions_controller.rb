class SessionsController < ApplicationController
  def new
    # render login form in sessions/new.html.erb
  end

  def create
   # authenticate the user
    # 1. try to find the user by their unique identifier
    @user = User.find_by({"email" => params["email"]})
    # 2. if the user exists -> check if they know their password
    if @user !=nil # -- "!=nil" asks if it is not nothing
    # 3. if they know their password -> login is successful
      if BCrypt::Password.new(@user["password"]) == params["password"]
       # add a cookie here -- "cookies" is a built in hash
        session["user_id"] = @user["id"] # session --> encrypted (2-way) cookie hash

        flash["notice"] = "Welcome."
        redirect_to "/places?logged_in_user_id=#{@user["id"]}" # http is stateless, so we have to define this specific user state
      else
        flash["notice"] = "Incorrect Password."
        redirect_to "/sessions"  
      end
    else
    # 4. if the user doesn't exist or they don't know their password -> login fails
      flash["notice"] = "User not found."
      redirect_to "/sessions"  
    end
  end

  def destroy
    # logout the user
    session["user_id"] = nil
    flash["notice"] = "Goodbye."
    redirect_to "/login"
  end
end
  