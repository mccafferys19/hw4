class PlacesController < ApplicationController
  before_action :require_login

   def index
    @user = User.find_by({ "id" => session["user_id"] })

    if @user != nil
      # Only fetch places that belong to this user
      @places = Place.where({ "user_id" => @user["id"] })
    else
      redirect_to "/login"
    end
  end

  def show
    @place = Place.find_by({ "id" => params["id"] })

    @user = User.find_by({ "id" => session["user_id"] })
    if @user && @place["user_id"] == @user["id"]
      @entries = Entry.where({ "place_id" => @place["id"], "user_id" => @user["id"] })
    else
      redirect_to "/places", notice: "Not authorized."
    end
  end

  def new
    @user = User.find_by({ "id" => session["user_id"] })

    if @user != nil
      # render the new place form
    else
      redirect_to "/login"
    end
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })

    if @user != nil
      @place = Place.new
      @place["name"] = params["name"]
      @place["user_id"] = @user["id"]  # Associate the place with the logged-in user
      @place.save
      redirect_to "/places"
    else
      redirect_to "/login"
    end
  end

end
