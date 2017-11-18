class V1::DemosController < ApplicationController
  skip_before_action :authenticate_user_from_token!, only: [:create]

  # POST /v1/demos
  def create
    @user = Demo::Create.new().call
    @auth_token = jwt_token(@user)
    render :create, status: :ok
  end
end
