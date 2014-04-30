require "aceitafacil/version"
require 'active_support/core_ext/class/attribute_accessors'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/core_ext/hash'
require "net/http"
require "net/https"

module Aceitafacil
    class Production
        BASE_URL = "api.aceitafacil.com"
    end

    class Test
        BASE_URL = "sandbox.api.aceitafacil.com"
    end

    @@environment = :test
    mattr_accessor :environment
    @@api_key = "e3c23d27ca61ac2cc3b8a1e4ed5340247221757d"
    mattr_accessor :api_key
    @@api_password ="773aebdf0d1202cac6837751f354c0a70553b3cd"
    mattr_accessor :api_password
end
