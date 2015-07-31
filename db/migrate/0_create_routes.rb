class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :origin_point, null: false
      t.string :destination_point, null: false
      t.integer :distance, null: false
    end
  end
end