class ChangePowerInverterProductionToInverterAndInverterProduction < ActiveRecord::Migration[8.0]
  def change
    rename_table :power_inverter_productions, :inverter_productions
    rename_column :inverter_productions, :identifier, :power_inverter_identifier

    create_table :power_inverters do |t|
      t.timestamps
    end
  end
end
