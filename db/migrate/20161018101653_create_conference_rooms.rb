class CreateConferenceRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :conference_rooms do |t|
      t.string :title
      t.string :description
      t.integer :available_booking
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
