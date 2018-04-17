class CreateHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :histories do |t|
      t.references :suit, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamp :checkOutTime
      t.timestamp :expectReturnTime
      t.timestamp :returnTime

      t.timestamps
    end
  end
end
