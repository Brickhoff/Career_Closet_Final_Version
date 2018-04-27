class CreateAdmins < ActiveRecord::Migration[5.1]
  def change
    create_table :admins do |t|
      t.string :name
      t.string :email
      t.string :code
      t.boolean :superadmin, default: false 
      t.boolean :email_confirmed, default: false
      t.string :password_digest
      t.string :remember_digest
      t.string :confirm_token
      t.string :reset_digest
      t.timestamp :reset_sent_at
      t.timestamps
    end
  end
end
