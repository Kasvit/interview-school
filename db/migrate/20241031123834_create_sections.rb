class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections do |t|
      t.integer :teacher_id
      t.integer :subject_id
      t.integer :classroom_id
      t.time :start_time
      t.time :end_time
      t.text :days_of_week, default: '[]'

      t.timestamps
    end
  end
end
