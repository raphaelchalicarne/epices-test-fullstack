class InverterProduction < ApplicationRecord
    validates :inverter_identifier, presence: true
    validates :datetime, presence: true
    validates :energy, presence: true

    belongs_to :inverter, foreign_key: :inverter_identifier

    def self.inverter_identifiers
        distinct.pluck(:inverter_identifier)
    end

    def self.production(inverter_identifier, date)
        where(inverter_identifier: inverter_identifier, datetime: date.beginning_of_day..date.end_of_day)
        .group_by_hour(:datetime)
        .sum(:energy)
    end

    def self.total_production(date)
        where(datetime: date.beginning_of_day..date.end_of_day)
        .group_by_hour(:datetime)
        .sum(:energy)
    end
end
