class PowerInverterProduction < ApplicationRecord
    validates :identifier, presence: true
    validates :datetime, presence: true
    validates :energy, presence: true
end
