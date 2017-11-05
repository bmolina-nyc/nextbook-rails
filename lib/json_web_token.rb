#require 'jwt'
class JsonWebToken
  def self.encode(payload, expiration = 24.hours.from_now)
    puts 'encoding...'
    payload = payload.dup
    payload['exp'] = expiration.to_i
    JWT.encode(payload, Rails.application.json_web_token_secret)
  end

  def self.decode(token)
    puts 'decoding...'
    JWT.encode(token, Rails.application.json_web_token_secret)
  end
end
