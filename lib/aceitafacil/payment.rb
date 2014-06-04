#encoding: utf-8

module Aceitafacil 
    class Payment
        include ActiveModel::Validations
        include ActiveModel::Model
        
        validates :card_token, :customer_id, presence: true
        validates :description, :paymentmethod_id, :total_amount, presence: true

        attr_accessor :card_token, :customer_id, :customer_name, :customer_email, :customer_email_language
        attr_accessor :organization_id, :organization_name, :paymentmethod, :charge_type, :payer, :total_amount
        attr_accessor :paid, :closed, :attempted, :attempted_count, :next_payment_attempt, :period_start
        attr_accessor :period_end, :items, :id, :description, :paymentmethod_id, :chargetype

        def initialize(params = {})
            @connection = Aceitafacil::Connection.new

            self.card_token = params[:card_token]
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
            
            params["card[token]"] = self.card_token
            params["customer[id]"] = self.customer_id.to_i
            params["customer[name]"] = self.customer_name unless self.customer_name.blank?
            params["customer[email]"] = self.customer_email unless self.customer_name.blank?
            params["customer[email_language]"] = self.customer_email_language unless self.customer_name.blank?
            params["description"] = self.description unless self.customer_name.blank?
            params["paymentmethod[id]"] = self.paymentmethod_id unless self.customer_name.blank?
            params["total_amount"] = Aceitafacil::Utils.format_number(self.total_amount)

            self.items.each_with_index do |item, index|
                params["item[#{index}][amount]"] = Aceitafacil::Utils.format_number(item.amount)
                params["item[#{index}][vendor_id]"] = item.vendor_id unless item.vendor_id.blank?
                params["item[#{index}][vendor_name]"] = item.vendor_name unless item.vendor_name.blank?
                params["item[#{index}][fee_split]"] = item.fee_split unless item.fee_split.blank?
                params["item[#{index}][description]"] = item.description unless item.description.blank?
                params["item[#{index}][trigger_lock]"] = item.trigger_lock unless item.trigger_lock.blank?
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
            
            if json["errors"]
                return json["errors"]
            else
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

                return true
            end
        end
    end
end