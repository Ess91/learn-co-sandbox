require './config/environment'

class UserController < ApplicationController
  
  get '/registrations/signup' do
    erb :'/registrations/signup'
  end
  
  post '/registrations' do
    @user = User.new(full_name: params["full_name"], username: params["username"], email: params["email"], password: params["password"])
    @user.save
    session[:user_id] = @user.id
      puts params
    redirect '/users/page'
  end
#post 'signup' - First time users, completes the forms. Once completed, the info will be saved and this we redirect them to their personal page 

  get '/sessions/login' do
    erb :'sessions/login'
  end 
  
  post '/sessions' do
    @user = User.find_by(email: params[:email], password: params[:password]) #Finds users' info
    if @user
      session[:user_id] = @user.id
      puts params
      redirect '/users/page' #if info is found, redirect them to personal page if not,
    end
    redirect '/sessions/login' #redirect to login page
  end
  
  get '/sessions/logout' do 
    session.clear
    redirect '/'
  end
  
  get '/users/home' do
 @user = User.find(session[:user_id])
  erb :'/users/home'
  end
end
  
#end 
