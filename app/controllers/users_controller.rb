class UsersController < ApplicationController
  before_action :require_current_user!, except: [:create, :new]

  def show
    if params[:id] == current_user.id
      render :show
    else
      flash.now[:notice] = "You do not have access to view this users show page"
    end
  end


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      render json: @user.errors.full_messages
    end
  end



  private
    def user_params
      params.require(:user).permit(:username, :password)
    end
end