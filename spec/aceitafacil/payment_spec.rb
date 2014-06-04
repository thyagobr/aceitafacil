# encoding: utf-8

require 'spec_helper'

describe Aceitafacil::Payment do
  let(:card_params) { { name: "Card Holder", number: "4012001038443335", cvv: "123", exp_date: "201807", customer_id: "1" } }

  let(:bank_params) {
    { 
      code: "001", 
      agency: "123-4", 
      account_type: 1, # 1 Corrent, 2 Poupança
      account_number: "1234-5", 
      account_holder_name: "Fulano",
      account_holder_document_type: 1, # 1 CPF, 2 CNPJ
      account_holder_document_number: "12345678909"
    }
  }

  let(:vendor_params) { 
    { 
      id: "2", name: "Vendor name", email: "vendor@vendor.com", bank: @bank
    } 
  }

  before do
    @card = Aceitafacil::Card.new(card_params)
    @bank = Aceitafacil::Bank.new(bank_params)
    @vendor = Aceitafacil::Vendor.new(vendor_params)

    @vendor.save
    @card.save

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
          card_token: @card.token
        } 
      }

      let(:item_params) {
        { 
          amount: 10.0, 
          vendor_id: @vendor.id, 
          vendor_name: @vendor.name, 
          fee_split: 1,
          description: "Test item",
          trigger_lock: "false"
        } 
      }

      it "should return false if an item is invalid" do
        @item = Aceitafacil::Item.new
        @item.valid?.should be_false
      end

      it "should return false if an item is invalid" do
        @payment = Aceitafacil::Payment.new

        @payment.valid?.should be_false
      end

      # it "should return false if an item is invalid" do
      #   incorrect_params = payment_params.dup
        
      #   incorrect_params[:item] = [Aceitafacil::Item.new]

      #   @payment = Aceitafacil::Payment.new(incorrect_params)
      #   @payment.save.should be_false
      # end

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