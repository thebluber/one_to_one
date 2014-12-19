class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :ws
      t.integer :ss

      t.timestamps
    end
  end
end
