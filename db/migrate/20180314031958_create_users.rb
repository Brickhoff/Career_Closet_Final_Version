class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :uin
      t.string :phone
      t.string :email
      t.boolean :available, default: true
      t.string :password_digest
      t.string :remember_digest
      t.timestamps
    end
  end
end
