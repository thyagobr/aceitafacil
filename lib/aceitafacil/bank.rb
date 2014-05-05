#encoding: utf-8

module Aceitafacil 
    class Bank
        attr_accessor :code, :agency, :account_type, :account_number, :account_holder_name
        attr_accessor :account_holder_document_type, :account_holder_document_number

        def initialize(params = {})
            self.code = params[:code]
            self.agency = params[:agency]
            self.account_type = params[:account_type]
            self.account_number = params[:account_number]
            self.account_holder_name = params[:account_holder_name]
            self.account_holder_document_type = params[:account_holder_document_type]
            self.account_holder_document_number = params[:account_holder_document_number]
        end
    end
end