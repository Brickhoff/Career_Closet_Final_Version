class CreateSuits < ActiveRecord::Migration[5.1]
  def change
    create_table :suits do |t|
      t.string :appid
      t.string :gender
      t.string :article
      t.string :size
      t.string :status
      t.timestamps
    end
    #add_index :suits, [:user_id, :created_at]
  end
end
