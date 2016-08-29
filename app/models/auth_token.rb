# Servicio para generar y verificar JWTs
require 'jwt'

class AuthToken
  attr_reader :valido, :claims, :headers

  def initialize(token)
    # Primero intentar decodificar
    decoded_token = self.class.decodificar(token)

    # Si se pudo decodificar el token es válido y extraemos los datos
    @valido = true
    @claims = HashWithIndifferentAccess.new decoded_token.first
    @headers = HashWithIndifferentAccess.new decoded_token.last
  rescue JWT::DecodeError
    # Si hay algún error de decodificación es inválido y no tiene claims ni
    # headers
    @valido = false
    @claims = {}
    @headers = {}
  end

  def valido?
    valido
  end

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

  private

  def self.hmac_secret
    Rails.application.secrets.secret_key_base
  end

  def self.algoritmo
    'HS512'
  end
end
