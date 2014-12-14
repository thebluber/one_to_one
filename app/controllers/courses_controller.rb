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
      redirect_to user_courses_path(current_user.id), notice: "Mentorship erfolgreich etabliert."
    else
      redirect_to user_courses_path(current_user.id), alert: "Kurs nicht vorhanden!"
    end
  end

  def destroy_mentorship
    @course = current_user.mentor.courses.find_by_id(params[:id])
    if @course
      current_user.mentor.courses.delete(@course)
      redirect_to user_courses_path(current_user.id), notice: "Mentorship erfolgreich gelöscht."
    else
      redirect_to user_courses_path(current_user.id), alert: "Kurs nicht vorhanden!"
    end
  end
end
