require 'aceitafacil'
require 'fakeweb'

FakeWeb.allow_net_connect = true

Aceitafacil.setup do |config|
  # Altere para production ao final dos seus testes
  config.environment = :test
  # Chave pública
  config.api_key = "e3c23d27ca61ac2cc3b8a1e4ed5340247221757d"
  # Chave privada
  config.api_password = "773aebdf0d1202cac6837751f354c0a70553b3cd"
end