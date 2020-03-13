require './config/environment'

class UserController < ApplicationController
  
  #SignUp
  
  get '/signup' do
    if logged_in?
      redirect '/books'    #Route - if user is able to login, thery are redirected to their personal page, if not they would
    else
      erb :'/users/signup'   #be redirected back to the signup
    end
  end
    
    
    post '/signup' do 
     if params[:username] != "" && params[:email] != "" && params[:password] != "" 
     @new_user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
     @new_user.save
     session[:user_id] = @new_user.id
     redirect to '/users/index'
    else
     redirect to '/signup'
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


  
  get '/books/index' do
    @current_user = User.find_by_id(session[:user_id])
    if @current_user
   
      redirect '/books/index'
    else
      erb :index
    end
  end
  
  #Logout
  get '/logout' do 
    session.clear
    redirect '/'
  end
 end 

