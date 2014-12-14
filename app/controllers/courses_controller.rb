class CoursesController < ApplicationController
  before_filter :require_login
  def index
    @user_courses = current_user.mentor.courses
    @other_courses = Course.all - @user_courses
    render :index
  end

  def make_mentorship
    @course = Course.find_by_id(params[:id])
    if @course
      current_user.mentor.courses << @course
      respond_to do |format|
        format.html { redirect_to courses_path, notice: "Mentorship erfolgreich etabliert." }
        format.js {}
      end
    else
      redirect_to courses_path, alert: "Kurs nicht vorhanden!"
    end
  end

  def destroy_mentorship
    @course = current_user.mentor.courses.find_by_id(params[:id])
    if @course
      current_user.mentor.courses.delete(@course)
      respond_to do |format|
        format.html { redirect_to courses_path, notice: "Mentorship erfolgreich gelöscht." }
        format.js {}
      end
    else
      redirect_to courses_path, alert: "Kurs nicht vorhanden!"
    end
  end
end
