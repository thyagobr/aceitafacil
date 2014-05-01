require 'spec_helper'

describe Aceitafacil::Connection do
  before do
    FakeWeb.allow_net_connect = true
    @connection = Aceitafacil::Connection.new
  end

  after do
    FakeWeb.allow_net_connect = false
  end
  
  it "should estabilish connection when was created" do
    @connection.environment.should_not be_nil
  end

  describe "making a request" do
    it "should make a request" do
      @card = Aceitafacil::Card.new(name: "Card Holder", number: "4012001038443335", cvv: "123", exp_date: "201807", customer_id: "1")
      response = @connection.post(:card, @card.params)
      response.body.should_not be_nil
      response.should be_kind_of Net::HTTPOK
    end
  end
end