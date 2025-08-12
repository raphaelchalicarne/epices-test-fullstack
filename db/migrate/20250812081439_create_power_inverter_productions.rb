class CreatePowerInverterProductions < ActiveRecord::Migration[8.0]
  def change
    create_table :power_inverter_productions do |t|
      t.timestamps
    end
  end
end
