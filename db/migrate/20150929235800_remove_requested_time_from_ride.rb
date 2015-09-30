class RemoveRequestedTimeFromRide < ActiveRecord::Migration
  def change
    remove_column :rides, :requested_time
  end
end
