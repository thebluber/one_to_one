require 'rails_helper'

RSpec.describe CourseBucketsController, :type => :controller do
  before do
    @user = create(:user)
    login_user @user
  end
  let(:bucket){ @user.student.course_buckets.last }

  describe "GET show" do
    it "returns http success" do
      get :show, id: bucket.id
      expect(response).to have_http_status(:success)
      expect(response).to render_template("show")
    end

    it "should redirect to root if course bucket not found" do
      get :show, id: "1234"
      expect(response).to have_http_status(:redirect)
      expect(flash[:alert]).not_to be_nil
    end
  end

  describe "POST make_bucketship" do
    let(:course){ create(:active_course) }

    it "should establish a bucketship between course and coursebucket" do
      post :make_bucketship, id: bucket.id, course_bucket: {course: course.id}
      expect(response).to redirect_to course_bucket_path(bucket.id)
      bucket.reload
      course.reload
      expect(bucket.courses.first).to eql course
      expect(course.course_buckets.first).to eql bucket
    end

    it "should redirect to show if course not found" do
      post :make_bucketship, id: bucket.id, course_bucket: {course: "1234"}
      expect(response).to redirect_to course_bucket_path(bucket.id)
      expect(flash[:alert]).not_to be_nil
    end
  end


  describe "DELETE destroy_bucketship" do
    before do
      @course = create(:active_course)
      bucket.courses << @course
    end
    it "should delete bucketship" do
      delete :destroy_bucketship, id: bucket.id, course_bucket: {course: @course.id}
      bucket.reload
      expect(bucket.courses.count).to eql 0
    end

    it "should redirect to show if course not found" do
      delete :destroy_bucketship, id: bucket.id, course_bucket: {course: "1234"}
      expect(response).to redirect_to course_bucket_path(bucket.id)
      expect(flash[:alert]).not_to be_nil
    end
  end
end
