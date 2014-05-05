#encoding: utf-8

module Aceitafacil 
    class Item
        attr_accessor :amount, :vendor_id, :vendor_name, :fee_split, :description, :trigger_lock

        def initialize(params = {})
            self.amount = params[:amount]
            self.vendor_id = params[:vendor_id]
            self.vendor_name = params[:vendor_name]
            self.fee_split = params[:fee_split]
            self.description = params[:description]
            self.trigger_lock = params[:trigger_lock]
        end
    end
end