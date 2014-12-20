require 'rails_helper'
RSpec.describe ApplicationHelper, :type => :helper do
  describe "#flash_message" do
    it "should generate html content for flash messages" do
      flash = {"notice" => "notification", "error" => "error", "alert" => "alert"}
      html_content = "<div class=\"alert alert-info\">notification</div><div class=\"alert alert-danger\">error</div><div class=\"alert alert-danger\">alert</div>"
      expect(helper.flash_message(flash)).to eql html_content
    end
  end

  describe "#icon" do
    it "should generate html content for icon" do
      icon = "<i class='fa fa-users fa-3'></i>"
      expect(helper.icon("users", 3)).to eql icon
    end
  end

  describe "#stringify_semester" do
    it "should stringify semester start dates to WS SS format" do
      ss = create(:semester, start: "2014-4-10")
      ws = create(:semester, start: "2014-10-10")
      expect(helper.stringify_semester ss).to eql "SS2014"
      expect(helper.stringify_semester ws).to eql "WS2014/2015"
    end
  end
end
