class UsersController < ApplicationController

before_action :authenticate_user!

def index
@book = Book.new
@users = User.all
@user = current_user
@books = @user.books.page(params[:page]).reverse_order
end

def show
@book = Book.new
@user = User.find(params[:id])
end

def new

end

def create
@user = User.new(user_params)
   if @user.save
      redirect_to user_path(@user.id)
       else
       @user = User.find(params[:id])
       render action: :edit
    end
end

def edit
@user = User.find(params[:id])
if current_user != @user
	redirect_to user_path(current_user)
end
end

def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
    else
    render action: :edit
end
end

def destroy
end
private
def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
end

end