class V1::UsersController < ApplicationController
  before_action :set_user, only: %i(show update destroy)

  # POST /v1/user
  def create
    @user = User.new(user_params)

    if @user.save
      render :create, status: :created
    else
      render_json_errors(@user)
    end
  end

  # GET /v1/user
  def show
    render :show, status: :ok
  end

  # PUT/PATCH /v1/user
  def update
    if @user.update(user_params)
      render :update, status: :ok
    else
      render_json_errors(@user)
    end
  end

  # DELETE /v1/user
  def destroy
    @user.destroy ? head(:no_content) : head(:bad_request)
  end

  private

  def set_user
    @user ||= current_user
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
