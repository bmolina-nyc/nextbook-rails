class ApplicationController < ActionController::API
  before_action :authenticate_user_from_token!

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Requester::ExternalServiceError, with: :bad_gateway

  private

  def bad_gateway
    head :bad_gateway
  end

  def not_found
    head :not_found
  end

  def render_json_errors(object)
    render json: object.errors.as_json(full_messages: true),
           status: :bad_request
  end

  protected

  def current_user
    token_from_request.blank? ? nil : authenticate_user_from_token!
  end
  alias_method :devise_current_user, :current_user

  def user_signed_in?
    !current_user.nil?
  end
  alias_method :devise_user_signed_in?, :user_signed_in?

  def authenticate_user_from_token!
    if claims && user = User.find_by(email: claims[0]['user'])
      @current_user = user
    else
      return render_unauthorized
    end
  end

  def claims
    JWT.decode(token_from_request, 'SECRET_KEY', true, {algorithm: 'HS256'})
  rescue
    nil
  end

  def jwt_token(user)
    expires = 2.weeks.from_now.to_i
    JWT.encode({ user: user.email, exp: expires }, 'SECRET_KEY', 'HS256')
  end

  def render_unauthorized(payload = { errors: { unauthorized: ['You are not authorized to perform this action.']}})
    render json: payload.merge(response: { code: 401 }),
           status: :unauthorized
  end

  def token_from_request
    request.headers['Authorization']
  end
end
