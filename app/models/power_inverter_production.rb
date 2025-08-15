class PowerInverterProduction < ApplicationRecord
    validates :identifier, presence: true
    validates :datetime, presence: true
    validates :energy, presence: true

    def self.identifiers
        distinct.pluck(:identifier)
    end

    def self.production(identifier)
        where(identifier: identifier)
        .group_by_hour(:datetime)
        .sum(:energy)
    end
end
