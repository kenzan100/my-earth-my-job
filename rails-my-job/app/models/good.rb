class Good < ApplicationRecord
  has_many :possessions
  has_many :spends

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