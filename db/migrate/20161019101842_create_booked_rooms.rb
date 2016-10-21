class CreateBookedRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :booked_rooms do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :all_day
      t.string :purpose
      t.integer :status, :default => 0, :limit => 1
      t.references :conference_room, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
