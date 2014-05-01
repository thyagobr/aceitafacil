require 'spec_helper'

describe Aceitafacil::Card do
  let(:card_params) { { name: "Card Holder", number: "4012001038443335", cvv: "123", exp_date: "201807", customer_id: "1" } }

  before do
    @card = Aceitafacil::Card.new(card_params)
  end

  describe "making a request" do
    it "to create a new card" do
      response = @card.save
      response.body.should_not be_nil
      response.should be_kind_of Net::HTTPSuccess
    end

    it "does something" do
      response = @card.save

      json = JSON.parse(response.body)

      json["card"].should_not be_nil
      json["card"][0]["token"].should_not be_nil
      json["card"][0]["card_brand"].should_not be_nil
      json["card"][0]["last_digits"].should_not be_nil
    end
  end
end