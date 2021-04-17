class Register < ApplicationRecord
  belongs_to :registerable, polymorphic: true
end