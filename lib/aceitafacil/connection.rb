#encoding: utf-8

module Aceitafacil
  class Connection
    attr_reader :environment

    def initialize
      @environment = eval(Aceitafacil.environment.to_s.capitalize)
      port = 443
      @http = Net::HTTP.new(@environment::BASE_URL,port)
      
      @http.ssl_version = :SSLv3 if @http.respond_to? :ssl_version
      @http.use_ssl = true
      @http.open_timeout = 10*1000
      @http.read_timeout = 40*1000
    end
    
    def post(path, params={})
      request = Net::HTTP::Post.new("/#{path}")
      request.basic_auth(Aceitafacil.api_key, Aceitafacil.api_password)

      request.set_form_data(params)

      response = @http.request(request)
      
      return response
    end
  end
end