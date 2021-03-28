class Equipment < ApplicationRecord
  validates_presence_of :name, :rate
  validates_numericality_of :rate
end
