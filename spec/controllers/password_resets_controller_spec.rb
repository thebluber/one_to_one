require 'rails_helper'

RSpec.describe PasswordResetsController, :type => :controller do
  let!(:user){ create(:user) }
  describe "GET edit" do
    it "should render edit template if there's a user with given token" do
      User.stub(:load_from_reset_password_token).with("1").and_return(user)
      get :edit, id: "1"
      expect(response).to render_template("edit")
    end

    it "should redirect to root if there's no user with given token" do
      get :edit, id: "1"
      expect(response).to redirect_to root_url
    end
  end

  describe "POST create" do
    it "should send password reset instruction" do
      post :create, email: user.email
      expect(response).to redirect_to(root_url)
      user.reload
      expect(ActionMailer::Base.deliveries.size).to eql 1
      expect(ActionMailer::Base.deliveries.last.to[0]).to eql user.email
      expect(ActionMailer::Base.deliveries.last.body).to match user.reset_password_token
    end
  end

  describe "PUT update" do
    it "should update password if there's a user with given token" do
      User.stub(:load_from_reset_password_token).with("1").and_return(user)
      old_pw = user.crypted_password
      salt = user.salt
      put :update, id: "1", user: {password: "newpassword"}
      expect(response).to redirect_to root_url
      user.reload
      expect(old_pw).not_to eql user.crypted_password
      expect(salt).not_to eql user.salt
    end

    it "should redirect to root if there's no user with given token" do
      old_pw = user.crypted_password
      salt = user.salt
      put :update, id: "1", user: {password: "newpassword"}
      expect(response).to redirect_to root_url
      expect(old_pw).to eql user.crypted_password
      expect(salt).to eql user.salt
    end
  end
end
