require './config/environment'

class UserController < ApplicationController
  
  #SignUp
  
  get '/signup' do
  #  if logged_in?
   #   redirect '/books/index'    #Route - if user is able to login, thery are redirected to their personal page, if not they would
  #  else
      erb :'/users/signup'   #be redirected back to the signup
    end
  end
    
    
    post '/signup' do 
     if params[:username] != "" && params[:email] != "" && params[:password] != "" 
     @new_user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
     @new_user.save
     session[:user_id] = @new_user.id
     redirect '/books/index'
    else
      erb :'/users/signup'
    end
  end
      
  
 
  #Login
 get '/login' do
    if logged_in?
    redirect '/books/index'
  else
    erb :'/users/login'
  end 
end 

  post '/login' do
    @user = User.find_by(:username => params[:username])
    
     if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/books'
  else
    redirect '/users/login'
  end
end

  
  #Logout
  get '/logout' do 
    session.clear
    redirect '/'
  end
# end 

