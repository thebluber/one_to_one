class CreateSemesters < ActiveRecord::Migration
  def change
    create_table :semesters do |t|
      t.date :start

      t.timestamps
    end
  end
end
