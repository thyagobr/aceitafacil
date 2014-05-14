# encoding: utf-8

# Use esse arquivo para configurar a integração com o aceitaFacil.
Aceitafacil.setup do |config|
  # Altere para production ao final dos seus testes
  config.environment = :test
  
  # Chave pública
  config.api_key = ""
  
  # Chave privada
  config.api_password = ""
end