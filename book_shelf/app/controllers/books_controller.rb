class BookController < ApplicationController
  
  #Create
  
    get '/books/new' do    #The first one is a GET request to load the form to create a new book.
    if logged_in?
      erb :'/books/new'
    else
      redirect '/users/login'
   end
  end 
  
   
    post '/books' do  
  @book = Book.create(:title => params[:title], :author => params[:author], :genre => params[:content], :price => params[:price])
  @books = Book.create(params)
  redirect "/books/#{@book.id}"
    end
  #create action. Responds to a POST request and creates a new book based on the params from the form and saves it to the database. Once the item is created, this action redirects to the show page
  
 # post '/books' do
  #  if params[:title] == "" || params[:author] == "" || params[:genre] == "" || params[:price] == "" # must have title, genre, content, & rating
      
   #   redirect to '/books/new'
  #  else
   #   user = current_user
    #  @book = Book.create(
     #   :title => params[:title],
      #  :author => params[:author],
       # :genre => params[:genre],
        #:price => params[:price],
        #:user_id => user.id)
     # redirect to "/books/#{@book.id}"
  #  end
  #end


#READ
  get '/books' do 
    if logged_in?
      @user = current_user
      @books = Book.all 
      erb :'books/index'
    else 
      redirect '/users/login'
  end 
end 

  
  
  get '/books/:id' do 
  if logged_in?
    @book = Book.find_by_id(params[:id])
    erb :'books/new'
  else 
    redirect 'users/login'
  end 
end
#Order to display a single article, we need a show action. This route uses a dynamic URL, we can access the ID of the article in the view through the params hash.


#UPDATE
  
#  get '/books/:id/edit' do  #loads the edit form in the browser 
   # @book = Book.find(params[:id])
  #  erb :'/books/edit'
 # end
  
   get '/books/:id/edit' do
    if logged_in?
      @book = Book.find_by_id(params[:id])
      if @book && @book.user == current_user
        erb :'books/edit'
      else
        redirect to '/books'
      end
    else
      redirect to '/login'
    end
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

#  delete '/books/:id' do #delete action
 #   @book = Book.find_by_id(params[:id])
#    @book.delete
 #   redirect '/books'
  
#  end 
#end 

delete '/books/:id' do
    @book = Book.find_by_id(params[:id])
    if @book.user_id == current_user.id
      @book.delete
    end
      redirect to "/books"
  end
end 


    
