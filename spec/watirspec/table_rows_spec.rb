# encoding: utf-8
require File.expand_path('spec_helper', File.dirname(__FILE__))

describe "TableRows" do

  before :each do
    browser.goto(WatirSpec.files + "/tables.html")
  end

  describe "#length" do
    it "returns the correct number of cells (table context)" do
      browser.table(:id, 'inner').rows.length.should == 1
      browser.table(:id, 'outer').rows.length.should == 3
    end

    it "returns the correct number of cells (page context)" do
      browser.rows.length.should == 14
    end
  end

  describe "#[]" do
    it "returns the row at the given index (table context)" do
      browser.table(:id, 'outer').rows[0].id.should == "outer_first"
    end

    it "returns the row at the given index (page context)" do
      browser.rows[0].id.should == "thead_row_1"
    end
  end

  describe "#each" do
      it "iterates through rows correctly" do
      # rows inside a table
      inner_table = browser.table(:id, 'inner')
      inner_table.rows.each_with_index do |r, index|
        r.id.should == inner_table.row(:index, index).id
        r.value.should == inner_table.row(:index, index).value
      end
      # rows inside a table (should not include rows inside a table inside a table)
      outer_table = browser.table(:id, 'outer')
      outer_table.rows.each_with_index do |r, index|
        r.id.should == outer_table.row(:index, index).id
        r.value.should == outer_table.row(:index, index).value
      end
    end
  end

end
