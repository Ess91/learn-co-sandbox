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
      if params[:title] == "" && params[:author] == "" && params[:genre] == "" && params[:price]
      redirect '/books/new'
    else 
  @book = Book.create(:title => params[:title], :author => params[:author], :genre => params[:genre], :price => params[:price])
  redirect "/books/#{@book.id}"
  else 
    redirect '/users/login'
  end
 end

     
       get '/books/:id' do 
  if logged_in?
    @book = Book.find_by_id(params[:id])
    erb :'/books/show'
  else 
    redirect '/users/login'
  end 
end

  get '/books/:id/edit' do
    @book = Book.find_by_id(params[:id])
    erb :'/books/edit'
  end
  
  patch '/books/:id' do #handles the edit form submission.
    @book = Book.find_by_id(params[:id])
    @book.title = params[:title]
    @book.author = params[:author]
    @book.genre = params[:genre]
    @book.price = params[:price]
    @book.save
  redirect "/books/#{@book.id}"
end


  delete '/books/:id' do
    Book.destroy(params[:id])
    redirect '/books'
  end
end