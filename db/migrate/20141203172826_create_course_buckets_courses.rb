class CreateCourseBucketsCourses < ActiveRecord::Migration
  def change
    create_table :course_buckets_courses, :id => false do |t|
      t.references :course
      t.references :course_bucket
    end
    add_index :course_buckets_courses, [:course_id, :course_bucket_id]
  end
end
