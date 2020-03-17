class BookController < ApplicationController
  
   #Create
  
    get '/books' do
"hello"
end 


  
    get '/books/new' do    #The first one is a GET request to load the form to create a new book.
    if logged_in?
      erb :'/books/new'
    else
      redirect '/users/login'
   end
  end 


  
end 