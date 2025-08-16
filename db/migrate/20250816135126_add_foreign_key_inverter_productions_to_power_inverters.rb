class AddForeignKeyInverterProductionsToPowerInverters < ActiveRecord::Migration[8.0]
	def up
    execute "INSERT INTO inverters (id, created_at, updated_at)
      SELECT DISTINCT inverter_identifier, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
      FROM inverter_productions
      GROUP BY inverter_identifier;"
    add_foreign_key :inverter_productions, :inverters, column: :inverter_identifier, primary_key: :id
  end

  def down
    remove_foreign_key :inverter_productions, :inverters, column: :inverter_identifier, primary_key: :id, if_exists: true
  end
end
