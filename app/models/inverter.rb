class Inverter < ApplicationRecord
  has_many :inverter_productions

  def self.identifiers
    distinct.pluck(:id)
  end
end
