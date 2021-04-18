module Domains
  module Time
    def total_active_duration(equipment, now, overrides: nil)
      started = nil
      events_to_use = overrides || equipment.events.order(:created_at)

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

    module_function :total_active_duration
  end
end