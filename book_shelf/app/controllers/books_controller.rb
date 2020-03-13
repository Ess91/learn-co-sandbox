class BookController < ApplicationController
  
  #Create
  
    get '/books/new' do    #The first one is a GET request to load the form to create a new book.
     # @books = Book.create(params)
    #  @books.save
    if is_logged_in?
      erb :'/books/new'
    else
      redirect '/login'
   end
  end 
  
   
    post '/books' do  #create action. Responds to a POST request and creates a new book based on the params from the form and saves it to the database. Once the item is created, this action redirects to the show page
 # @book = Book.create(:title => params[:title], :author => params[:author], :genre => params[:content], :price => params[:price])
  @books = Book.create(params)
  redirect "/books/#{@book.id}"
    end
#end 

#Read 
  get '/books' do 
    @books = Book.all 
    erb :'/books/index'
  end 
  
  get '/books/:id' do #order to display a single article, we need a show action. This route uses a dynamic URL, we can access the ID of the article in the view through the params hash.
  @book = Book.find_by_id(params[:id])
  erb :'/books/show'
end

#Update
  
  get '/books/:id/edit' do  #loads the edit form in the browser 
    @book = Book.find(params[:id])
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

  
  #Delete 

  delete '/books/:id' do #delete action
    @book = Book.find_by_id(params[:id])
    @book.delete
    redirect '/books'
  
  end 
end 
    
