require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "bookreader"
  end
  
 #HOMEPAGE
  get '/' do 
    erb :index
  end 


    def logged_in?
      !!current_user
    end

    def current_user
   @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  get '/books/index' do #may not need this code but getting error to say I need it
    erb :'/books/index'
  end 
end 
