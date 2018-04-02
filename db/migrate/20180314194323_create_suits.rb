class CreateSuits < ActiveRecord::Migration[5.1]
  def change
    create_table :suits do |t|
      #t.belongs_to :users, index: true
      #t.belongs_to :admins, index: true
      t.string :appid
      t.string :gender
      t.string :article
      t.string :size
      t.string :status
      #t.references :user, foreign_key: true
      t.timestamps
    end
    #add_index :suits, [:user_id, :created_at]
  end
end
