class Admin::CoursesController < Admin::AdminController
  def index
    @active_courses = Course.where(active: true)
    @inactive_courses = Course.where(active: false)
    render :index
  end

  def show
    @course = Course.find_by_id(params[:id])
    if @course
      @mentors = @course.mentors.map(&:user)
      @students = @course.students.map(&:user)
      render :show
    else
      redirect_to admin_courses_path, alert: "Kurs nicht vorhanden."
    end
  end

  def edit
    @course = Course.find_by_id(params[:id])
    if @course
      render :edit
    else
      redirect_to admin_courses_path, alert: "Kurs nicht vorhanden."
    end
  end

  def update
    @course = Course.find_by_id(params[:id])
    if @course
      @course.title = params[:course][:title] if params[:course][:title]
      @course.active = params[:course][:active] unless params[:course][:active].nil?
      if @course.save
        respond_to do |format|
          format.html { redirect_to admin_courses_path, notice: "Kurs erfolgreich updated!" }
          format.js {}
        end
      else
        flash.now[:error] = @course.errors.full_messages.join(" ")
        render :edit
      end
    else
      redirect_to admin_courses_path, alert: "Kurs nicht vorhanden."
    end
  end

  def new
    @course = Course.new
    render :new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to admin_courses_path, :notice => "Neuer Kurs erfolgreich angelegt."
    else
      flash.now[:error] = @course.errors.full_messages.join(" ")
      render :new
    end
  end
  private

  def course_params
    params.require(:course).permit(:title, :active)
  end
end
