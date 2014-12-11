require 'rails_helper'

RSpec.describe UserSessionsController, :type => :controller do
  let!(:user){ create(:user) }
  describe "POST create" do
    it "should login user" do
      post :create, email: user.email, password: "12345678"
      expect(response).to redirect_to(root_url)
      expect(assigns[:current_user]).to eql user
    end
    it "should render new template in case of invalid user data" do
      post :create, email: user.email, password: "123"
      expect(response).to render_template("new")
      expect(flash[:alert]).to eql "Email or password was invalid"
    end
  end

  describe "DELETE destroy" do
    it "should logout user" do
      login_user(user)
      delete :destroy
      expect(response).to redirect_to(root_url)
    end
  end
end
