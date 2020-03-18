class BookController < ApplicationController
  
   
  #READ
    get '/books' do
    if logged_in?
      @user = current_user 
      @books = Book.all 
      erb :'/books/index'
    else
      redirect '/login'
    end 
end 


  #CREATE
    get '/books/new' do    #The first one is a GET request to load the form to create a new book.
    if logged_in?
      erb :'/books/new'
    else
      redirect '/users/login'
   end
  end 

  # post '/books' do  
#  @book = Book.create(:title => params[:title], :author => params[:author], :genre => params[:content], :price => params[:price])
 # @books = Book.create(params)
#  redirect "/books/#{@book.id}"
 #   end
 
    post '/books' do 
       if logged_in? && params[:title] != "" && params[:author] != "" && params[:genre] != "" && params[:price] != ""
         @new_book = Book.create(params)
         @new_book.user_id = current_user.id 
         @new_book.save 
         redirect '/users/index'
       else
         redirect '/users/index'
       end 
     end 
         
         
  #create action. Responds to a POST request and creates a new book based on the params from the form and saves it to the database. Once the item is created, this action redirects to the show page
end 