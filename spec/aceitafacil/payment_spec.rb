# encoding: utf-8

require 'spec_helper'

describe Aceitafacil::Payment do

  before :each do
    @vendor = Aceitafacil::Vendor.find(2)
    @card = Aceitafacil::Card.find_by_customer_id(1)[0]
    @item = Aceitafacil::Item.new(item_params)
    @payment = Aceitafacil::Payment.new(payment_params)
  end

  context 'payments crud' do
    describe "request to create an payment" do
       let(:payment_params) { 
        { 
          description: "Test payment",
          customer_id: 1,
          customer_name: "Fulano de Tal",
          customer_email: "fulano@fulanodetal.com.br",
          customer_email_language: "pt-BR",
          paymentmethod_id: 1, # 1 Credit Card, 2 billet
          total_amount: 10,
          items: [@item],
          card: @card
        } 
      }

      let(:item_params) {
        { 
          amount: 10.0, 
          vendor_id: @vendor.id, 
          vendor_name: @vendor.name, 
          fee_split: 1,
          description: "Test item",
          trigger_lock: false
        } 
      }

      it "should return a successfully response" do
        response = @payment.save
        response.should be_kind_of Net::HTTPSuccess
      end

      it "should return a correct params" do
        response = @payment.save

        @payment.id.should_not be_nil
        @payment.organization_id.should_not be_nil
        @payment.organization_name.should_not be_nil
        @payment.paymentmethod.should eq("CREDITCARD")
        @payment.chargetype = "AVISTA"
        @payment.payer = "CUSTOMER"
        @payment.paid = true
      end
    end
  end
end