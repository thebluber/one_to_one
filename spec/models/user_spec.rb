require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should allow_value("bla@student.uni-tuebingen.de", "bla@uni-tuebingen.de", "bla@bla.uni-tuebingen.de").for(:email).with_message("Nur Email-Adressen der Universität werden akzeptiert") }
  it { should_not allow_value("bla@gmail.com", "bla@hotmail.com").for(:email) }
  it { should have_one(:student) }
  it { should have_one(:mentor) }

  describe "valide user" do
    subject { create(:user) }
    it { should have_attributes(first_name: "John") }
    it { should have_attributes(last_name: "Doe") }
  end

  describe "student and mentor accounts" do
    let(:user) { create(:user) }
    it "should have student and mentor accounts after creation" do
      expect(user.student).not_to be_nil
      expect(user.mentor).not_to be_nil
    end

    it "should destroy student and mentor accounts after deletion" do
      id = user.id
      user.destroy
      expect(Student.find_by(user_id: id)).to be_nil
      expect(Mentor.find_by(user_id: id)).to be_nil
    end
  end
end
