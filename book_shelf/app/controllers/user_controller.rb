require './config/environment'

class UserController < ApplicationController
  
  #SignUp
  get '/signup' do
  #  if logged_in?
   #   redirect to '/books/index'    #Route - if user is able to login, thery are redirected to their personal page, if not they would
   # else
      erb :'/users/signup'   #be redirected back to the signup
    end
  end
    
    
    post '/signup' do 
      @user = User.new(name: params["name"], email: params["email"], password: params["password"])
      @user.save
      session[:user_id] = @user.id
      puts params
    redirect '/users/index'
  end
      
    # if params[:name] != "" && params[:username] != "" && params[:password] != ""
     # @user = User.new(:name => params[:name], :username => params[:username], :password => params[:password])
    #  @user.save
     # session[:user_id] = @user.id
    #  erb :signup
    #  redirect '/users/index'
    #else
     # redirect '/users/signup'
  #  end 
 # end 
    
  #  @user = User.new(full_name: params["full_name"], username: params["username"], email: params["email"], password: params["password"])
  #  @user.save
   # session[:user_id] = @user.id
    #  puts params
  #  redirect '/books/index'
#  end
#post 'signup' - First time users, completes the forms. Once completed, the info will be saved and this we redirect them to their personal page 

 
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
    redirect '/books/index'
  else
    redirect '/users/login'
  end
end


  
  get '/books/index' do
    @current_user = User.find_by_id(session[:user_id])
    if @current_user
   
      erb :'/books/index'
    else
      erb :index
    end
  end
  
  #Logout
  get '/logout' do 
    session.clear
    redirect '/'
  #else
 #   redirect '/'
  end
# end 
#end 
#end 