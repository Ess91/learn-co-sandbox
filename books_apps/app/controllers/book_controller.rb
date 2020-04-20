class BookController < ApplicationController

  # Create
  get '/books/new' do # takes you to the create a movie review page
    if is_logged_in?
      erb :'books/new'
    else
      redirect to '/login'
    end
  end

  post '/books' do
    if params[:title] == "" || params[:author] == "" || params[:genre] == "" || params[:comments] == "" # must have title, author, genre, & comments
      
      redirect to '/books/new'
    else
      user = current_user
      @book = Book.create(
        :title => params[:title],
        :author => params[:author],
        :genre => params[:genre],
        :comments => params[:comments],
        :user_id => user.id)
      redirect to "/books/#{@book.id}"
    end
  end


  # Read
  get '/books' do
    if is_logged_in?
      @user = current_user
      @books = @user.books.all
      erb :'books/index'
    else
      redirect to '/login'
    end
  end

  get '/books/:id' do
    if is_logged_in?
      @book = Book.find_by_id(params[:id])
      if @book.user_id == session[:user_id]
        erb :'books/show'
      elsif @book.user_id != session[:user_id]
        redirect '/books'
      end
    else
      redirect to '/books'
    end
  end

  # Update
  get '/books/:id/edit' do
    if is_logged_in?
      @book = Book.find_by_id(params[:id])
      if @book.critic_id == session[:book_id]
        erb :'books/edit'
      else
        redirect to '/books'
        end
    else
      redirect to '/login'
    end
  end

  patch '/books/:id' do
    if params[:title] == "" || params[:author] == "" || params[:genre] == "" || params[:comments] == ""
      redirect to "/books/#{params[:id]}/edit"
    else
      @book = Book.find_by_id(params[:id])
      @book.title = params[:title]
      @book.author = params[:author]
      @book.genre = params[:genre]
      @book.comments = params[:comments]
      @book.user_id = current_user.id
      @book.save
      redirect to "/books/#{@book.id}"
    end
  end

  # Delete
  delete '/books/:id/delete' do
    if is_logged_in?
      @book = Book.find_by_id(params[:id])
      if @book.user_id == session[:user_id]
        @book.delete
        redirect to '/books'
      end
    else
      redirect to '/login'
    end
  end

end