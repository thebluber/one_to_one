require 'rails_helper'

RSpec.describe Admin::CoursesController, :type => :controller do
  let!(:user){ create(:admin_user) }
  before do
    login_user user
  end
  describe "GET index" do
    it "should display all courses" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET new" do
    it "should render new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "GET edit" do
    let(:course){ create(:active_course) }
    it "should render edit template" do
      get :edit, id: course.id
      expect(response).to render_template("edit")
    end

    it "should redirect to index" do
      get :edit, id: "1234"
      expect(response).to redirect_to admin_courses_path
    end
  end

  describe "POST create" do
    it "should create new course with valid data" do
      post :create, course: {title: "new course", active: true}
      expect(response).to redirect_to admin_courses_path
      expect(Course.last.title).to eql "new course"
      expect(Course.last.active).to eql true
    end

    it "should not create new course with invalid data" do
      post :create, course: {title: "", active: true}
      expect(response).to render_template("new")
    end
  end

  describe "PUT update" do
    let!(:course){ create(:active_course) }
    it "should update title" do
      put :update, id: course.id, course: {title: "new title"}
      expect(response.status).to eql 302
      course.reload
      expect(course.title).to eql "new title"
    end

    it "should update active" do
      expect(course.active).to eql true
      put :update, id: course.id, course: {active: false}
      expect(response.status).to eql 302
      course.reload
      expect(course.active).to eql false
      put :update, id: course.id, course: {active: true}
      course.reload
      expect(course.active).to eql true
    end

    it "should render edit template in case of invalid data" do
      put :update, id: course.id, course: {active: ""}
      expect(response).to render_template("edit")
      expect(flash[:error]).not_to be_nil
    end

    it "should redirect to index if course not found" do
      put :update, id: "1234"
      expect(response).to redirect_to admin_courses_path
      expect(flash[:alert]).not_to be_nil
    end
  end
end
