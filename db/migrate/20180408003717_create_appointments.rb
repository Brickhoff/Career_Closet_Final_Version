class CreateAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :appointments do |t|
      t.datetime :time
      t.timestamp :appointments,  null: true
      t.references :user

      t.timestamps
    end
  end
end
