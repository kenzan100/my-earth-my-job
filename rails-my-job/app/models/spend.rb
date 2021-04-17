class Spend < ApplicationRecord
  belongs_to :good

  class << self
    def total
      all.reduce(0) do |sum, spend|
        sum += spend.good.price
      end
    end
  end
end