require 'active_support'
require "builder"
require "net/http"
require "net/https"
require "json"

module Aceitafacil
    class Production
        BASE_URL = "api.aceitafacil.com"
    end

    class Test
        BASE_URL = "sandbox.api.aceitafacil.com"
        # BASE_URL = "127.0.0.1:3000"
    end

    @@environment = :test
    mattr_accessor :environment
    @@api_key = "e3c23d27ca61ac2cc3b8a1e4ed5340247221757d"
    mattr_accessor :api_key
    @@api_password = "773aebdf0d1202cac6837751f354c0a70553b3cd"
    mattr_accessor :api_password

    def self.setup
        yield self
    end

    def self.site
        environment = eval(Aceitafacil.environment.to_s.capitalize)
        return "https://#{environment::BASE_URL}" 
    end
    
    class MissingArgumentError < StandardError; end
end

[:version, :card, :connection, :vendor, :bank, :payment, :item, :utils].each { |lib| require "aceitafacil/#{lib}" }