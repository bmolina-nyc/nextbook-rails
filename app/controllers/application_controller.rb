class ApplicationController < ActionController::API
  rescue_from Requester::ExternalServiceError, with: :bad_gateway

  private

  def bad_gateway
    head :bad_gateway
  end

  def render_json_errors(object)
    render json: object.errors.as_json(full_messages: true),
           status: :bad_request
  end
end
