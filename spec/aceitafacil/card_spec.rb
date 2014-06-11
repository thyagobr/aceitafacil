require 'spec_helper'

describe Aceitafacil::Card do
  let(:card_params) { { name: "Card Holder", number: "4012001038443335", exp_date: "201807", customer_id: "1" } }

  before do
    @card = Aceitafacil::Card.new(card_params)
    #@card.save
  end

  describe "instatiating a new card" do
    it "should return valid true when" do
      @invalid = Aceitafacil::Card.new
      @invalid.valid?.should be_false
    end

    it "should return message erros for fields" do
      @invalid = Aceitafacil::Card.new
      @invalid.valid?
      [:customer_id, :number, :name, :exp_date].each do |key|
        @invalid.errors.messages.keys.should include(key)
      end
    end
  end

  describe "make a remove call" do
    it "should return nil if card is nil" do
      remote_card = Aceitafacil::Card.remove(nil)
      remote_card.should be_nil
    end

    it "should remote a remote card" do
      @card.save
      
      token = @card.token

      remote_card = Aceitafacil::Card.remove(@card)
      remote_card.token.should eq(token)
      remote_card.status.should eq("removed")
    end
  end

  describe "fetching existent cards" do
    it "should be nil if customer_id is not passed" do
      @card.save
      @cards = Aceitafacil::Card.find_by_customer_id(nil) 
      @cards.should be_nil
    end

    it "should return a list cards" do
      @card.save

      @cards = Aceitafacil::Card.find_by_customer_id("1") 
      @cards.count.should == 1
    end
  end

  describe "making a save call" do
    it "should return an http success" do
      response = @card.save
      
      response.should be_kind_of Net::HTTPSuccess
    end

    it "should create a new remote card" do
      @card.save

      @card.token.should_not be_nil
      @card.card_brand.should_not be_nil
      @card.last_digits.should_not be_nil
    end
  end
end