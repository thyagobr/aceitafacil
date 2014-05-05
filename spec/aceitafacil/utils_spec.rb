# encoding: utf-8

require 'spec_helper'

describe Aceitafacil::Utils do
  describe "testing a utils specs" do
    it "should return correct formated number" do
      Aceitafacil::Utils.format_number(10.5).should eq(1050)
    end
  end
end