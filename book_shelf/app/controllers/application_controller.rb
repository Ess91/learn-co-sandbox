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


  # helpers do
    def logged_in?
     # !!current_user
      !!session[:user_id]
    end

    def current_user
    #  @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    @user = User.find(session[:user_id])
    end
  end