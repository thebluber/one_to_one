class CourseBucketsController < ApplicationController
  before_filter :require_login
  def show
    @bucket = current_user.student.course_buckets.find_by_id(params[:id])
    if @bucket
      @courses = Course.all - @bucket.courses
      render :show
    else
      redirect_back_or_to root_path, alert: "Coursebucket nicht vorhanden!"
    end
  end

  def make_bucketship
    @bucket = current_user.student.course_buckets.find_by_id(params[:id])
    @course = Course.find_by_id(params[:course_bucket][:course])
    if @bucket && @course
      @bucket.courses << @course
      respond_to do |format|
        format.html { redirect_to course_bucket_path(@bucket.id), notice: "Kurs erfolgreich in die Liste aufgenommen." }
        format.js {}
      end
    else
      redirect_to course_bucket_path(@bucket.id), alert: "Kurs oder Liste nicht gefunden!"
    end
  end

  def destroy_bucketship
    @bucket = current_user.student.course_buckets.find_by_id(params[:id])
    @course = Course.find_by_id(params[:course_bucket][:course]) if @bucket
    if @course
      @bucket.courses.delete(@course)
      respond_to do |format|
        format.html { redirect_to course_bucket_path(@bucket.id), notice: "Kurs erfolgreich aus der Liste entfernt." }
        format.js {}
      end
    else
      redirect_to course_bucket_path(@bucket.id), alert: "Kurs oder Liste nicht gefunden!"
    end
  end
end
