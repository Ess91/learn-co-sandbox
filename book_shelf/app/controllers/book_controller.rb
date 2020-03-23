class BookController < ApplicationController
  
   
  #READ
    get '/books' do
      if logged_in?
      @books = Book.all 
      erb :'/books/index'
    else
      redirect '/users/login'
    end 
  end 
    #DONE


  #CREATE
    get '/books/new' do    #The first one is a GET request to load the form to create a new book.
    if logged_in? 
      erb :'/books/new'
    else
      redirect '/users/login'
   end
  end 
  

  post '/books' do 
    if logged_in?
      elsif params[:title] == "" && params[:author] == "" && params[:genre] == "" && params[:price]
      redirect '/books/new'
    else 
  @book = Book.create(:title => params[:title], :author => params[:author], :genre => params[:genre], :price => params[:price])
  redirect "/books/#{@book.id}"
end 
    redirect '/users/login'
  end
 end
     #line 28 - it checks to see if there are any blank spaces, redirects to new.erb 
     
  get '/books/:id' do 
    if logged_in?
    @book = Book.find_by_id(params[:id])
    erb :'/books/show'
  else 
    redirect '/users/login'
  end 
end

  get '/books/:id/edit' do
    if logged_in?
      if @book && @book.user == current_user #only want the current_user to edit their own books
    @book = Book.find_by_id(params[:id])
    erb :'/books/edit'
  else 
    redirect 'users/login'
   end 
end
  #In order to edit the book. it will be able to access the book's id first through :id before it is able to edit the book
  
  patch '/books/:id' do #handles the edit form submission.
    if logged_in?
      @book = Book.find_by_id(params[:id])
      if @book && @book.user == current_user
         @book.update(:title => params[:title], :author => params[:author], :genre => params[:genre], :price => params[:price])
      redirect "/books/#{@book.id}"
    else
      redirect "/books/#{@book.id}/edit"
  end
end 
  else 
redirect 'users/login'
end 


  delete '/books/:id' do
    if logged_in?
    @book = Book.find_by_id(params[:id])
    if @book && @book.user == current_user
    @book.destroy
    redirect '/books'
  else 
    redirect 'users/login'
  end
end

# :id is the whole object 