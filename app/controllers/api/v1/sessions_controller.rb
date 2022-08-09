class Api::V1::SessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:email])
    if @user.present? && @user.authenticate(params[:password])
      render json: UserSerializer.new(@user)
    else
      render json: { error: 'Invalid Credentials' }, status: :unauthorized
    end
  end
end