require 'active_support/core_ext'
require 'active_model'
require "builder"
require "net/http"
require "net/https"
require "json"

module Aceitafacil
    def self.clear_data
        @connection = Aceitafacil::Connection.new
        @connection.post("cleardata")
    end

    class Production
        BASE_URL = "api.aceitafacil.com"
    end

    class Test
        BASE_URL = "sandbox.api.aceitafacil.com"
        # BASE_URL = "127.0.0.1:3000"
    end

    @@environment = :test
    mattr_accessor :environment
    @@api_key = "c3794e9a24b4f302d8c2f2fd77db345122295905"
    mattr_accessor :api_key
    @@api_password = "34e066b02fc6443575f12ff0bb3af876e52f19ba"
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