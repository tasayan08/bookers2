class UsersController < ApplicationController
before_action :correct_user, only: [:edit]

  def index
    @users = User.all
    @user=User.find(current_user.id)
    @book=Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:profile_update] = "You have updated user successfully."
       redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    # @books = Book.find(current_user.id)
    @books = @user.books
  end


  private

  def user_params
   params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def correct_user
  @user = User.find(params[:id])
  redirect_to(user_path(current_user)) unless @user == current_user
  end
end
