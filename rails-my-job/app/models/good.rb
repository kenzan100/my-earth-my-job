class Good < ApplicationRecord
  has_many :possessions
  has_many :spends

  has_many :events, as: :eventable
  has_many :good_attributes

  include PolymorphicSelectable

  def self.posessing
    joins(:possessions)
  end

  def purchase
    ApplicationRecord.transaction do
      spends.create!

      if possessions.any?
        possessions.first.increment!(:quantity)
      else
        possessions.create!(quantity: 1)
      end
    end
  end
end