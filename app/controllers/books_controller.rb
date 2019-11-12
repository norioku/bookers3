class BooksController < ApplicationController

before_action :authenticate_user!

def index
@book = Book.new
@books =Book.all
@users = User.all
@user = current_user
end

def show
@book = Book.new
@books = Book.find(params[:id])
@user = @books.user
@users = User.all
end

def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully created."
    redirect_to book_path(@book)
  else
    @books =Book.all
    @user = current_user
    render action: :index
  end
end

def edit
    @book = Book.find(params[:id])
    if current_user != @book.user
  redirect_to books_path
end
  end

def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully created."
    redirect_to book_path
  else
  @books =Book.all
  @user = current_user
  render action: :edit
end
end

def destroy
  book = Book.find(params[:id])
  if book.destroy
    flash[:notice] = "Book was successfully created."
    redirect_to books_path
  else
    render action: :new
  end
end

private
  def book_params
    params.require(:book).permit(:title, :body)

  end
end