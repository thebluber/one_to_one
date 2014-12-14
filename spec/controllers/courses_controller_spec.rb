require 'rails_helper'

RSpec.describe CoursesController, :type => :controller do
  let(:user){ create(:user) }
  before do
    login_user user
  end

  describe "GET index" do
    it "returns http success" do
      get :index, user_id: user.id
      expect(response).to have_http_status(:success)
      expect(response).to render_template("index")
    end
  end

  describe "POST make_mentorship" do
    let(:course){ create(:active_course) }
    it "should establish mentorship between user and course" do
      post :make_mentorship, user_id: user.id, id: course.id
      user.mentor.reload
      course.reload
      expect(user.mentor.courses.first).to eql course
      expect(course.mentors.first).to eql user.mentor
    end

    it "should redirect to index if failed" do
      post :make_mentorship, user_id: user.id, id: "1234"
      expect(response).to redirect_to courses_path
      expect(flash[:alert]).not_to be_nil
    end
  end

  describe "DELETE destroy_mentorship" do
    before do
      @course = create(:active_course)
      user.mentor.courses << @course
    end
    it "should delete mentorship" do
      delete :destroy_mentorship, user_id: user.id, id: @course.id
      user.mentor.reload
      expect(user.mentor.courses.count).to eql 0
    end

    it "should redirect to index if course not found" do
      delete :destroy_mentorship, user_id: user.id, id: "1234"
      expect(response).to redirect_to courses_path
      expect(flash[:alert]).not_to be_nil
    end
  end
end
