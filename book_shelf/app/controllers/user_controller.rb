require './config/environment'

class UserController < ApplicationController
  
  get '/signup' do 
      erb :'/users/signup'
    end
  
  post '/signup' do 
      if logged_in?
        redirect '/books/index'
     elsif params[:username] != "" && params[:email] != "" && params[:password] != "" 
     @new_user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
     @new_user.save
     session[:user_id] = @new_user.id
     redirect '/books/index'
    else
      redirect '/users/signup'
    end
  end

  #LOGIN
  
 get '/login' do
    erb :'/users/login'
end 

  post '/login' do
    @current_user = User.find_by(:username => params[:username])
    
     if @current_user && @current_user.authenticate(params[:password])
    session[:user_id] = @current_user.id
    redirect '/books/index'
  else
    redirect '/users/login'
  end
 end
 
  #LOGOUT 
  
  get '/logout' do 
    session.clear
    redirect '/'
  end
end 

