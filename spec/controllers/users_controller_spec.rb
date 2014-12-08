require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  describe "GET new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST create" do
    it "should registrate new user" do
      post :create, user: {first_name: "Lala", last_name: "Lulu", email: "lala.lulu@uni-tuebingen.de", password: "12345678"}
      expect(response).to redirect_to(root_url)
      expect(User.first.first_name).to eql "Lala"
      expect(User.first.last_name).to eql "Lulu"
      expect(User.first.email).to eql "lala.lulu@uni-tuebingen.de"
      expect(assigns[:current_user]).to eql User.first
    end
  end

end
