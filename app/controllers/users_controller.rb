class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :update, :destroy]
  before_action :authenticate_request, only: [ :show, :update, :destroy]


  def show 
    render json: UserBlueprint.render(@user, view: :normal), status: :ok
  end

  def create
    user = User.new(user_params)
    
    if user.save
      render json: user, status: :created
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update 
    if @user.update(user_params)
      render json: @user, status: :ok 
    else 
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      render json: nil, status: :ok 
    else 
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:email, :zipcode, :password, :password_confirmation)
  end
end