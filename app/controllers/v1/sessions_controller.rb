class V1::SessionsController < ApplicationController

  # GET /v1/session
  def create
    @user = User.find_by(email: params[:email].downcase)

    if @user&.valid_password?(params[:password])
      render :create, status: :created
    else
      head :unauthorized
    end
  end

  # POST /v1/session
  def show
    current_user ? head(:ok) : head(:unauthorized)
  end

  # DELETE /v1/session
  def destroy
    nilify_token
    current_user&.save ? head(:ok) : head(:unauthorized)
  end

  private

  def nilify_token
    current_user&.authentication_token = nil
  end
end
