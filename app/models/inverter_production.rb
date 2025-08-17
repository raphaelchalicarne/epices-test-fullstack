class InverterProduction < ApplicationRecord
  validates :inverter_identifier, presence: true
  validates :datetime, presence: true
  validates :energy, presence: true

  belongs_to :inverter, foreign_key: :inverter_identifier
end
