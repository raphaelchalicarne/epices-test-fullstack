class ChangePowerInverterProductionToInverterAndInverterProduction < ActiveRecord::Migration[8.0]
  def change
    rename_table :power_inverter_productions, :inverter_productions
    rename_column :inverter_productions, :identifier, :inverter_identifier

    create_table :inverters do |t|
      t.timestamps
    end
  end
end
