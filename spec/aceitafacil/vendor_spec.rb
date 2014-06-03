# encoding: utf-8

require 'spec_helper'

describe Aceitafacil::Vendor do
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
    @bank = Aceitafacil::Bank.new(bank_params)
    @vendor = Aceitafacil::Vendor.new(vendor_params)
  end

  describe "instatiating a new card" do
    it "should return valid true when valid? is called" do
      @vendor = Aceitafacil::Vendor.new
      @vendor.valid?.should be_false
    end

    it "should return valid true when it is saved" do
      @vendor = Aceitafacil::Vendor.new
      @vendor.save.should be_false
    end

    it "should return valid true when it is saved" do
      @vendor = Aceitafacil::Vendor.new(id: 1, name: "Vendor name", email: "vendor@email.com", bank: nil)
      @vendor.save.should be_false
    end

    it "should return valid true when it is saved" do
      @vendor = Aceitafacil::Vendor.new(id: 1, name: "Vendor name", email: "vendor@email.com", bank: Aceitafacil::Bank.new)

      @vendor.save.should be_false
    end

    it "should return message erros for fields" do
      @vendor = Aceitafacil::Vendor.new
      @vendor.valid?
      [:id, :email, :name, :bank].each do |key|
        @vendor.errors.messages.keys.should include(key)
      end
    end
  end

  describe "fetching existent vendors" do
    it "should be nil if customer_id is not passed" do
      @vendor = Aceitafacil::Vendor.find(nil) 
      @vendor.should be_nil
    end

    # it "should return a list vendors" do
    #   @vendor = Aceitafacil::Vendor.find(2)
      
    #   @vendor.id.should == vendor_params[:id]
    #   @vendor.name.should == vendor_params[:name]
    #   @vendor.email.should == vendor_params[:email]
    # end
  end

  describe "making a update call" do
    it do 
      response = @vendor.update
      
      response.should be_kind_of Net::HTTPSuccess
    end

    it "should update a remote vendor" do
      @vendor.save
      @vendor.name = "Chuck Norris"
      @vendor.update
      @vendor = Aceitafacil::Vendor.find(@vendor.id)
      @vendor.name.should eq("Chuck Norris")
    end
  end  

  describe "making a save call" do
    it "should create a new remote vendor" do
      response = @vendor.save
      puts response.inspect
      response.should be_kind_of Net::HTTPOK
    end
  end
end