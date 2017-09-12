class V1::UsersController < ApplicationController

  # POST /v1/users
  def create
  end

  # GET /v1/users
  def show
  end

  # PUT/PATCH /v1/users
  def update
  end

  # DELETE /v1/users
  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
