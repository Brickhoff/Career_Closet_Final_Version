class CreateRenters < ActiveRecord::Migration[5.1]
  def change
    create_table :renters do |t|
      t.timestamp :checkOutTime, null: false
      t.timestamp :expectReturnTime, null: false
      t.timestamp :returnTime, null: true
      t.string :status, default: "Available"
      
      t.references :user
      t.references :suit
      t.timestamps
    end
  end
end
