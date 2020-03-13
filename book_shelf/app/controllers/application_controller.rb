require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "bookreader"
  end
  
 #Homepage
  get '/' do 
    erb :index
  end 


  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
    @user = User.find(session[:critic_id])
  end
end