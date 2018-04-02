class CreateRenters < ActiveRecord::Migration[5.1]
  def change
    create_table :renters do |t|
      t.timestamp :checkOutTime, null: false
      t.timestamp :pickUpTime, null: true
      t.timestamp :expectReturnTime, null: false
      t.timestamp :returnTime, null: true
      t.string :rentStatus, default: "Available"
      
      t.references :user
      t.references :car
      t.timestamps
    end
  end
end
