class UserController < ApplicationController

  # SIGN UP
    get '/signup' do
      if is_logged_in?
        redirect to '/books'
      else
        erb :'user/create_user'
      end
    end

    post '/signup' do
      if is_logged_in?
        redirect to '/books'
      elsif params[:username] == "" || params[:password] == ""
        redirect to '/signup'
      else
        @book = Book.create(username: params[:username], password: params[:password])
        @book.save
        session[:user_id] = @user.id #logged in. where is the sessions hash initially declared?
        redirect to '/books'
      end
    end

    # LOGIN
    
    get '/login' do #renders the log in page
      if is_logged_in?
        redirect '/books'
      else
        erb :'user/login'
      end
    end

    post "/login" do
      @user = User.find_by(username: params[:username]) #find the user
      if @user && @user.authenticate(params[:password]) #check password matches
        session[:user_id] = @user.id   #log them in
        redirect "/books" #show them their reviews
      else
        redirect "/login"
      end
    end

    # Log out
    get '/logout' do
      if is_logged_in?
        session.clear
        redirect '/login'
      else
        redirect '/'
      end
  end



end