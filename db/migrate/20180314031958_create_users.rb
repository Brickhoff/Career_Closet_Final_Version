class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :uin
      t.string :phone
      t.string :email
      t.boolean :available, default: true
      t.boolean :email_confirmed, default: false
      t.integer :suitCount, default: 0
      t.string :confirm_token
      t.string :password_digest
      t.string :remember_digest
      t.string :reset_digest
      t.timestamp :reset_sent_at
      t.timestamps
    end
  end
end
