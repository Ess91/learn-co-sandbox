require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do                  #Route - if user is able to login, thery are redirected to their personal page, if not they would 
    if logged_in?             #be redirected back to the welcome (index) page
      redirect 'users/index'
    else
      erb :index
    end 
  end 


  # helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end
end

