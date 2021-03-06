class Event < ApplicationRecord
  belongs_to :eventable, polymorphic: true

  enum status_changed_to: { active: 1, stopped: 2, pending: 3 }, _default: :pending
  alias_attribute :status, :status_changed_to
end
