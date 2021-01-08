# frozen_string_literal: true

# Class responsible for JWT encryption and decryprion
class JwtService
  ALGORITHM = 'HS256'

  class << self
    def encode(payload)
      JWT.encode(payload, auth_secret, ALGORITHM)
    end

    def decode(token)
      JWT.decode(token, auth_secret, ALGORITHM).first.deep_symbolize_keys
    rescue JWT::DecodeError
      nil
    end

    def auth_secret
      Rails.application.credentials.secret_key_base[32..64]
    end
  end
end
