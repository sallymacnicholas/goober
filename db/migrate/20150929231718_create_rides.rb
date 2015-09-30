class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.string :pickup
      t.string :dropoff
      t.integer :passengers
      t.string :status, default: 'active'
      t.timestamp :requested_time
      t.timestamp :accepted_time
      t.timestamp :pickup_time
      t.timestamp :dropoff_time
      t.integer :rider_id
      t.integer :driver_id

      t.timestamps null: false
    end
  end
end
