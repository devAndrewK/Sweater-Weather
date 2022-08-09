class Api::V1::UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    # binding.pry
    if @user.save
      render json: UserSerializer.new(@user), status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.permit(:email, :password, :password_confirmation)
    end
end
