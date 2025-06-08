class EntriesController < ApplicationController
    before_action :require_login  # protects all actions by default

  def index
    # e.g., show all entries (if you have this)
    @entries = Entry.all
  end

  def show
    @entry = Entry.find(params[:id])
  end 

  def new
    @place_id = params[:place_id]
    @entry = Entry.new
  end

  def create
    @user = User.find_by({"id" => session["user_id"]})
    # only allow logged in users to enter an activity
    if @user != nil
      @entry = Entry.new
      @entry["title"] = params["title"]
      @entry["description"] = params["description"]
      @entry["occurred_on"] = params["occurred_on"]
      @entry.uploaded_image.attach(params["uploaded_image"])
      @entry["place_id"] = params["place_id"]
      @entry["user_id"] = @current_user["id"]  # assign user_id here
      @entry.save
      redirect_to "/places/#{@entry["place_id"]}"
    else
      redirect_to "/login"
    end
  end

end
