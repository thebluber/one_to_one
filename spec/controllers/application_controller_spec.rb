require 'rails_helper'

RSpec.describe ApplicationController, :type => :controller do
  controller do
    def index
      not_authenticated
    end
  end
  it "allows redirect to root url if not authenticated" do
    get :index
    expect(response).to redirect_to root_path
    expect(flash[:alert]).to eql "Bitte loggen Sie sich ein!"
  end
end
