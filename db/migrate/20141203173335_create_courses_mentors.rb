class CreateCoursesMentors < ActiveRecord::Migration
  def change
    create_table :courses_mentors, :id => false do |t|
      t.references :course
      t.references :mentor
    end
    add_index :courses_mentors, [:course_id, :mentor_id]
  end
end
