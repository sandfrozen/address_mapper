class CreateBusinesses < ActiveRecord::Migration[5.0]
  def change
    create_table :businesses do |t|
      t.float :latitude
      t.float :longitude
      t.string :name
      t.string :address

      t.timestamps
    end
  end
end
