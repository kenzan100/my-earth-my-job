class Reference < ApplicationRecord
  belongs_to :referencible, polymorphic: true

end