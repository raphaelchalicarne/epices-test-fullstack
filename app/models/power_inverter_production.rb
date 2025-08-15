class PowerInverterProduction < ApplicationRecord
    validates :identifier, presence: true
    validates :datetime, presence: true
    validates :energy, presence: true

    def self.identifiers
        distinct.pluck(:identifier)
    end

    def self.production(identifier, date)
        where(identifier: identifier, datetime: date.beginning_of_day..date.end_of_day)
        .group_by_hour(:datetime)
        .sum(:energy)
    end

    def self.total_production(date)
        where(datetime: date.beginning_of_day..date.end_of_day)
        .group_by_hour(:datetime)
        .sum(:energy)
    end
end
