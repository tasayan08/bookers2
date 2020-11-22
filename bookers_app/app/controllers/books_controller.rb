class BooksController < ApplicationController
 before_action :correct_user, only: [:edit, :update]

 def new
   @book = Book.new
 end

 def create
   @book = Book.new(book_params)
   @book.user_id = current_user.id
   if @book.save
    redirect_to book_path(@book.id)
    flash[:notice] = "You have created book successfully"
   else
    @books = Book.all
    @user = current_user
    render "index"
   end
 end

 def index
  @books = Book.all
  @book = Book.new
  @user = User.find(current_user.id)
 end

 def show
  @book = Book.find(params[:id])
  @book_new = Book.new
  @user = @book.user
 end

 def edit
  @book = Book.find(params[:id])
 end

 def update
  @book = Book.find(params[:id])
  if @book.update(book_params)
   flash[:update] = "You have updated book successfully."
   redirect_to book_path(@book.id)
  else
   render "edit"
  end
 end

 def destroy
  book = Book.find(params[:id])
  book.destroy
  redirect_to books_path
 end

 private

  def book_params
   params.require(:book).permit(:title, :body)
  end

  def correct_user
   @book = Book.find(params[:id])
   redirect_to(books_path) unless @book.user == current_user
  end
end
