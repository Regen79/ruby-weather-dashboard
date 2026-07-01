class CreateMeasurements < ActiveRecord::Migration[8.1]
  def change
    create_table :measurements do |t|
      t.decimal :temperature
      t.decimal :humidity
      t.references :device, null: false, foreign_key: true

      t.timestamps
    end
  end
end
