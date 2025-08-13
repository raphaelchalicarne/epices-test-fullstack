class CreatePowerInverterProductions < ActiveRecord::Migration[8.0]
  def change
    create_table :power_inverter_productions do |t|
      t.integer :identifier
      t.datetime :datetime
      t.integer :energy

      t.timestamps
    end
  end
end
