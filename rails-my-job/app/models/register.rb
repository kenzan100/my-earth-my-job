class Register < ApplicationRecord
  belongs_to :registerable, polymorphic: true

  # TODO: no transactional gurantee yet. do this in DB
  def overlaps?
    self.class.all.any? do |other|
      (start_hour > other.start_hour && start_hour < other.end_hour) ||
        (end_hour > other.start_hour && end_hour < other.end_hour)
    end
  end
end