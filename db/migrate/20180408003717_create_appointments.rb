class CreateAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :appointments do |t|
      t.datetime :time
      t.string :slot
      t.references :user

      t.timestamps
    end
  end
end
