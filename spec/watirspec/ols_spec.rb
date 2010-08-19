# encoding: utf-8
require File.expand_path('spec_helper', File.dirname(__FILE__))

describe "Ols" do

  before :each do
    browser.goto(WatirSpec.files + "/non_control_elements.html")
  end

  describe "#length" do
    it "returns the number of ols" do
      browser.ols.length.should == 2
    end
  end

  describe "#[]" do
    it "returns the ol at the given index" do
      browser.ols[0].id.should == "favorite_compounds"
    end
  end

  describe "#each" do
    it "iterates through ols correctly" do
      browser.ols.each_with_index do |ol, index|
        ol.id.should == browser.ol(:index, index).id
        ol.value.should == browser.ol(:index, index).value
      end
    end
  end

end
