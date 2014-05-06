#encoding: utf-8

module Aceitafacil 
    class Payment
        include ActiveModel::Validations
        
        validates :card, :customer_id, :customer_name, :customer_email, :customer_email_language, presence: true
        validates :description, :paymentmethod_id, :total_amount, presence: true

        attr_accessor :card, :customer_id, :customer_name, :customer_email, :customer_email_language
        attr_accessor :organization_id, :organization_name, :paymentmethod, :charge_type, :payer, :total_amount
        attr_accessor :paid, :closed, :attempted, :attempted_count, :next_payment_attempt, :period_start
        attr_accessor :period_end, :items, :id, :description, :paymentmethod_id, :chargetype

        def initialize(params = {})
            @connection = Aceitafacil::Connection.new

            self.card = params[:card]
            self.customer_id = params[:customer_id]
            self.customer_name = params[:customer_name]
            self.customer_email = params[:customer_email]
            self.customer_email_language = params[:customer_email_language]
            self.description = params[:description]
            self.paymentmethod_id = params[:paymentmethod_id]
            self.total_amount = params[:total_amount]
            self.items = params[:items]
        end

        def params
            params = {}
            
            params["card[token]"] = self.card.token
            params["customer[id]"] = self.customer_id.to_i
            params["customer[name]"] = self.customer_name
            params["customer[email]"] = self.customer_email
            params["customer[email_language]"] = self.customer_email_language
            params["description"] = self.description
            params["paymentmethod[id]"] = self.paymentmethod_id
            params["total_amount"] = Aceitafacil::Utils.format_number(self.total_amount)

            self.items.each_with_index do |item, index|
                params["item[#{index}][amount]"] = Aceitafacil::Utils.format_number(item.amount)
                params["item[#{index}][vendor_id]"] = item.vendor_id
                params["item[#{index}][vendor_name]"] = item.vendor_name
                params["item[#{index}][fee_split]"] = item.fee_split
                params["item[#{index}][description]"] = item.description
                params["item[#{index}][trigger_lock]"] = item.trigger_lock
            end
            
            return params
        end

        def save
            return false if not self.valid?
            
            self.items.each do |item|
                return false if not item.valid?
            end

            response = @connection.post("payment", params)

            json = JSON.parse(response.body)

            self.id = json["id"]
            self.organization_id = json["organization_id"]
            self.organization_name = json["organization_name"]
            self.paymentmethod = json["paymentmethod"]
            self.chargetype = json["chargetype"]
            self.payer = json["payer"]
            self.paid = json["paid"]
            self.closed = json["closed"]
            self.attempted = json["attempted"]
            self.attempted_count = json["attempted_count"]
            self.next_payment_attempt = json["next_payment_attempt"]
            self.period_start = json["period_start"]
            self.period_end = json["period_end"]

            return response
        end
    end
end