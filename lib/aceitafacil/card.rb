#encoding: utf-8

module Aceitafacil 
    class Card
        attr_accessor :customer_id, :number, :name, :cvv, :exp_date

        def initialize(params = {})
            @connection = Aceitafacil::Connection.new

            self.customer_id = params[:customer_id]
            self.number = params[:number]
            self.name = params[:name]
            self.cvv = params[:cvv]
            self.exp_date = params[:exp_date]
        end

        def params
            params = {}

            params["customer[id]"] = self.customer_id
            params["card[name]"] = self.name
            params["card[number]"] = self.number
            params["card[cvv]"] = self.cvv
            params["card[exp_date]"] = self.exp_date

            return params
        end

        def save
            @connection.post("card", params)
        end
    end
end