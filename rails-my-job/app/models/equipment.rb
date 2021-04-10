class Equipment < ApplicationRecord
  has_many :references, as: :referencible
  has_many :job_attributes
  has_many :events
  accepts_nested_attributes_for :references, :job_attributes, :events,
                                allow_destroy: true

  validates_presence_of :name, :hourly_rate
  validates_numericality_of :hourly_rate

    def self.current_val(now)
    all.reduce(0) do |sum, equipment|
      duration_sum = equipment.total_active_duration(now)
      sum += duration_sum.to_f * (equipment.hourly_rate / 3600)
    end
  end

  def self.current_rate
    Equipment.active.sum(&:hourly_rate)
  end

  def self.active
    partition[0]
  end

  def self.proposed
    partition[1]
  end

  def self.partition
    Equipment.all.partition do |eq|
      eq_status = eq.events.order(:created_at).last
      next if eq_status.nil?

      eq_status.active?
    end
  end

  def total_active_duration(now, overrides: nil)
    started = nil
    events_to_use = overrides || self.events.order(:created_at)

    diffs = events_to_use.each_with_object([]) do |ev, arr|
      started = ev.created_at if ev.active? && started.nil?
      if ev.stopped? && started
        arr << ev.created_at - started
        started = nil
      end
    end

    diffs << (now - started) if started

    diffs.sum
  end

  def skills_acquired

  end

  def cooling_period
    1.day
  end

  def noise
    Rails.cache.fetch(
      "#{cache_key_with_version}/success_rate_noise",
      expires_in: 24.hours,
      ) do
      rand(-10..10)
    end
  end

  def finished?
    false
  end

  def reference_link
    references.map(&:url).join(", ")
  end
end
