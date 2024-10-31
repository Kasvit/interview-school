class CreateClassrooms < ActiveRecord::Migration[6.0]
  def change
    create_table :classrooms do |t|
      t.string :room_number, null: false

      t.timestamps
    end
  end
end
