class CreatePowerInverters < ActiveRecord::Migration[8.0]
  def change
    create_table :power_inverters do |t|
      t.timestamps
    end
  end
end
