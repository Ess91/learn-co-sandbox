require './config/environment'

class UserController < ApplicationController
  
  get '/signup' do
    if logged_in?
      redirect to '/users/page'     #Route - if user is able to login, thery are redirected to their personal page, if not they would
    else
      erb :'/users/signup'   #be redirected back to the signup
    end
  end
  
  post '/signup' do
    @user = User.new(full_name: params["full_name"], username: params["username"], email: params["email"], password: params["password"])
    @user.save
    session[:user_id] = @user.id
      puts params
    redirect '/users/page'
  end
#post 'signup' - First time users, completes the forms. Once completed, the info will be saved and this we redirect them to their personal page 

 # get 'login' do
  #  if logged_in?
   # redirect '/users/page'
#  else
 #   erb :'/sessions/login'
#  end 
  
 # post '/login' do
  #  @user = User.find_by(username: params[:username], password: params[:password]) #Finds users' info
   # if @user
    #  session[:user_id] = @user.id #(need to add a new column of user id)
     # puts params
    #  redirect '/users/page' #if info is found, redirect them to personal page if not,
  #  end
   # redirect '/sessions/login' #redirect to login page
  #end
  
  
  
  #get "/login" do
	#	erb '/sessions/login'
	#end

 get 'login' do
    if logged_in?
    redirect '/users/page'
  else
    erb :'/users/login'
  end 

  post '/login' do
    @user = User.find_by(:username => params[:username])
    
     if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/users/page'
  else
    redirect '/users/login'
  end
end

  
  get '/page' do
		if logged_in?
			erb :page
		else
			redirect '/login'
		end
	end
  
  
  get '/sessions/logout' do 
    session.clear
    redirect '/'
  end
 end 
end 
