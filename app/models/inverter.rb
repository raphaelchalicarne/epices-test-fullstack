class Inverter < ApplicationRecord
  has_many :inverter_productions, foreign_key: :inverter_identifier, dependent: :destroy

  def self.identifiers
    distinct.pluck(:id)
  end

  def self.total_hourly_production(date)
    joins(:inverter_productions)
    .where(inverter_productions: { datetime: date.beginning_of_day..date.end_of_day })
    .group_by_hour(:datetime)
    .sum(:energy)
  end
end
