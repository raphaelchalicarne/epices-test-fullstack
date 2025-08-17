class Inverter < ApplicationRecord
  has_many :inverter_productions, foreign_key: :inverter_identifier, dependent: :destroy

  def self.identifiers
    distinct.pluck(:id)
  end
end
