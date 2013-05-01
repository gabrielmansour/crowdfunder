require "spec_helper"

describe UserMailer do
  describe "new_pledge" do
    let(:user)  { create(:user, email: "wilfred@laurier.com", first_name: "Wilfred", last_name: "Laurier") }
    let(:donor) { create(:user, first_name: "Lester", last_name: "Pearson") }
    let(:pledge) { create(:pledge, project: create(:project, user: user), user: donor) }
    let(:mail) { UserMailer.new_pledge(pledge) }


    it "renders the headers" do
      mail.subject.should == "Someone has backed your project!"
      mail.to.should == ["wilfred@laurier.com"]
      mail.from.should == ["crowdfunder@example.com"]
    end

    it "renders the body" do
      mail.body.encoded.should include("Wilfred Laurier")
      mail.body.encoded.should include("Lester Pearson")
      mail.body.encoded.should include("5D Glasses")

      mail.body.encoded.should include("for <strong>$1.00</strong>")
    end
  end

end
