class ApplicationController < ActionController::API
  acts_as_token_authentication_handler_for User, fallback: :none

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def not_found
    head(:not_found)
  end

  def render_json_errors(object)
    render json: object.errors.as_json(full_messages: true),
           status: :bad_request
  end
end
