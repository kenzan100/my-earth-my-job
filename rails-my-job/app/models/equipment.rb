class Equipment < ApplicationRecord
  has_many :references, as: :referencible
  has_many :job_attributes
  has_many :events, as: :eventable

  accepts_nested_attributes_for :references, :job_attributes, :events,
                                allow_destroy: true

  validates_presence_of :name, :hourly_rate
  validates_numericality_of :hourly_rate

  include PolymorphicSelectable

  class << self
    def current_rate
      Equipment.active.sum(&:hourly_rate)
    end

    def active
      partition[0]
    end

    def proposed
      partition[1]
    end

    def skills_acquired(now)
      active.each_with_object({}) do |eq, hash|
        hash.merge!(eq.skills_acquired(now)) do |k, old, new|
          old + new
        end
      end
    end

    private

    def partition
      Equipment.all.partition do |eq|
        eq_status = eq.events.order(:created_at).last
        next if eq_status.nil?

        eq_status.active?
      end
    end
  end

  def events_to_use
    if events.any? { |ev| ev.new_record? }
      events.sort_by(&:created_at)
    else
      events.order(:created_at)
    end
  end

  def skills_acquired(now)
    job_attributes.each_with_object({}) do |ja, hash|
      next if ja.ditractor

      hash[ja.name] = Domains::Time.new(now).total_active_duration(events_to_use)
    end
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

  def reference_links
    references.map(&:url)
  end
end
