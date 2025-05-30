class EntriesController < ApplicationController

  def new
  end

  def create
    @user = User.find_by({"id" => session["user_id"]})
    # only allow logged in users to enter an activity
    if @user != nil
      @entry = Entry.new
      @entry["title"] = params["title"]
      @entry["description"] = params["description"]
      @entry["occurred_on"] = params["occurred_on"]
      @entry["place_id"] = params["place_id"]
      @entry["user_id"] = @user["id"]  # assign user_id here
      @entry.save
      redirect_to "/places/#{@entry["place_id"]}"
    else
      redirect_to "/login"
    end
  end

end
