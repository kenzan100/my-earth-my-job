class Equipment < ApplicationRecord
  has_many :references, as: :referencible
  has_many :job_attributes
  accepts_nested_attributes_for :references, :job_attributes,
                                allow_destroy: true

  validates_presence_of :name, :hourly_rate
  validates_numericality_of :hourly_rate

  enum status: { proposed: 1, active: 2 }, _default: :proposed

  def self.current_val(now)
    all.reduce(0) do |sum, equipment|
      till_when = equipment.finished? ? equipment.finished_at : now
      delta = till_when - equipment.created_at
      pp [till_when, equipment.created_at, (delta.to_f / 3600)]
      sum += (delta.to_f / 3600) * equipment.hourly_rate
    end
  end

  def self.current_rate
    Equipment.active.sum(&:hourly_rate)
  end

  def finished?
    false
  end

  def reference_link
    references.map(&:url).join(", ")
  end
end
