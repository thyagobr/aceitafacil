#encoding: utf-8

module Aceitafacil 
    class Vendor
        attr_accessor :id, :name, :email, :bank

        def initialize(params = {})
            @connection = Aceitafacil::Connection.new

            self.id = params[:id]
            self.name = params[:name]
            self.email = params[:email]
            self.bank = Bank.new(params[:bank]) if params[:bank]
        end

        def params
            params = {}

            params["vendor[id]"] = self.id
            params["vendor[name]"] = self.name
            params["vendor[email]"] = self.email
            params["vendor[bank][code]"] = self.bank.code
            params["vendor[bank][agency]"] = self.bank.agency
            params["vendor[bank][account_type]"] = self.bank.account_type
            params["vendor[bank][account_number]"] = self.bank.account_number
            params["vendor[bank][account_holder_name]"] = self.bank.account_holder_name
            params["vendor[bank][account_holder_document_type]"] = self.bank.account_holder_document_type
            params["vendor[bank][account_holder_document_number]"] = self.bank.account_holder_document_number

            return params
        end

        def self.find(vendor_id)
            return nil if vendor_id.nil?

            @connection = Aceitafacil::Connection.new

            find_params = {}

            find_params["vendor[id]"] = vendor_id

            response = @connection.get("vendor", find_params)

            json = JSON.parse(response.body)

            bank = {
                code: json["vendor"]["bank"][0]["code"],
                agency: json["vendor"]["bank"][0]["agency"],
                account_type: json["vendor"]["bank"][0]["account_type"],
                account_number: json["vendor"]["bank"][0]["account_number"],
                account_holder_name: json["vendor"]["bank"][0]["account_holder_name"],
                account_holder_document_type: json["vendor"]["bank"][0]["account_holder_document_type"],
                account_holder_document_number: json["vendor"]["bank"][0]["account_holder_document_number"]
            }
            
            vendor = Aceitafacil::Vendor.new(
                id: json["vendor"]["id"], 
                name: json["vendor"]["name"], 
                email: json["vendor"]["email"],
                bank: bank
            )

            return vendor
        end

        def update
            response = @connection.put("vendor", params)

            return response
        end

        def save
            response = @connection.post("vendor", params)

            return response
        end
    end
end