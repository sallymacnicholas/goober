class AddEtaAndDistanceToRide < ActiveRecord::Migration
  def change
    add_column :rides, :eta, :integer
    add_column :rides, :distance, :integer
  end
end
