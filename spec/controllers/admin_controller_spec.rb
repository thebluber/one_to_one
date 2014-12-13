require 'rails_helper'

RSpec.describe Admin::AdminController, :type => :controller do
  let(:user){ create(:user) }
  controller do
    def index
      redirect_to admin_courses_path, notice: "success!"
    end
  end
  it "should authenticate wether user is logged in" do
    get :index
    expect(response).to redirect_to root_path
    expect(flash[:alert]).to eql "Bitte loggen Sie sich ein!"
  end

  it "should authenticate wether user is an admin" do
    login_user user
    get :index
    expect(response).to redirect_to root_path
    expect(flash[:alert]).to eql "Kein Admin Recht!"
  end

  it "should allow authenticated user to access page" do
    user.make_admin!
    login_user user
    get :index
    expect(response).to redirect_to admin_courses_path
    expect(flash[:notice]).to eql "success!"
  end
end
