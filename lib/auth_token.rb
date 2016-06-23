# Servicio para generar y verificar JWTs
require 'jwt'

class AuthToken
  # Genera un token con expiración y el payload. Especifica el algoritmo por
  # seguridad
  def self.generar(payload = {})
    payload[:exp] = 24.hours.from_now.to_i

    JWT.encode payload, hmac_secret, algoritmo
  end

  # Decodifica el token, valida que sea nuestro y verifica los claims
  def self.decodificar(token)
    JWT.decode token,
      hmac_secret, true, {
        algorithm: algoritmo,
        verify_expiration: true
      }
  end

  # Si hay algún error de decodificación es inválido
  def self.valido?(token)
    decodificar(token).present?
  rescue JWT::DecodeError
    false
  end

  def self.invalido?(token)
    !valido?(token)
  end

  private

  def self.hmac_secret
    Rails.application.secrets.secret_key_base
  end

  def self.algoritmo
    'HS512'
  end
end
