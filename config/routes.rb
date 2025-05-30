Rails.application.routes.draw do
   # Custom routes for session login/logout
  get("/login", {:controller => "sessions", :action => "new"})   # Show login form
  post("/login", {:controller => "sessions", :action => "create"})   # Handle login form submit
  get("/logout", {:controller => "sessions", :action => "destroy"})  # Handle logout
 
  get("/", { :controller => "places", :action => "index" })
  resources "entries"
  resources "places"
  resources "sessions"
  resources "users"
end
