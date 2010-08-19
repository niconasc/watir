# encoding: utf-8
require File.expand_path('spec_helper', File.dirname(__FILE__))

describe "CheckBoxes" do

  before :each do
    browser.goto(WatirSpec.files + "/forms_with_input_elements.html")
  end

  describe "#length" do
    it "returns the number of checkboxes" do
      browser.checkboxes.length.should == 7
    end
  end

  describe "#[]" do
    it "returns the checkbox at the given index" do
      browser.checkboxes[0].id.should == "new_user_interests_books"
    end
  end

  describe "#each" do
    it "iterates through checkboxes correctly" do
      browser.checkboxes.each_with_index do |c, index|
        c.name.should == browser.checkbox(:index, index).name
        c.id.should == browser.checkbox(:index, index).id
        c.value.should == browser.checkbox(:index, index).value
      end
    end
  end

end
