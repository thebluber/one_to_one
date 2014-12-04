class CreateCourseBuckets < ActiveRecord::Migration
  def change
    create_table :course_buckets do |t|
      t.string :semester
      t.integer :student_id

      t.timestamps
    end
  end
end
