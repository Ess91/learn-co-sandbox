class BookController < ApplicationController
  
   
  #READ
    get '/books' do
      @books = Book.all 
      
   # if logged_in?
    #  @user = current_user 
     # @books = Book.all 
    # books = Book.all
      erb :'/books/index'
  #  else
    #  redirect '/login'
    #end 
end 


  #CREATE
    get '/books' do    #The first one is a GET request to load the form to create a new book.
    if logged_in?
      erb :'/books/new'
    else
      redirect '/users/login'
   end
  end 
  

  post '/books' do  
  @book = Book.create(:title => params[:title], :author => params[:author], :genre => params[:genre], :price => params[:price])
  redirect "/books/#{@book.id}"
end
 

     
       get '/books/:id' do 
  if logged_in?
    @book = Book.find_by_id(params[:id])
    erb :'/books/index'
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

#First, we pull the article by the ID from the URL, then we update the title and content attributes and save. The action ends with a redirect to the article show page.

  delete '/books/:id' do
    Book.destroy(params[:id])
    redirect '/books'
  end

end	

         
         
  #create action. Responds to a POST request and creates a new book based on the params from the form and saves it to the database. Once the item is created, this action redirects to the show page
#end 