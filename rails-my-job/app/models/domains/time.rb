module Domains
  class Time
    attr_reader :equipment
    def initialize(equipment)
      @equipment = equipment
    end

    def total_active_duration(now, overrides: {})
      started = nil

      events_to_use = overrides[Event]&.sort_by(&:created_at) || equipment.events.order(:created_at)
      time_speeds = overrides[TimeSpeed]&.sort_by(&:starting) || TimeSpeed.order(:starting)

      diffs = events_to_use.each_with_object([]) do |ev, arr|
        started = ev.created_at if ev.active? && started.nil?
        if ev.stopped? && started
          arr << game_time(started, ev.created_at, time_speeds)
          started = nil
        end
      end

      diffs << game_time(started, now, time_speeds) if started

      diffs.sum
    end

    private

    def game_time(starting, ending, time_speeds)
      return (ending - starting) if time_speeds.empty?

      # discard the time_speeds range nothing to do with given duration
      time_speeds = time_speeds.reject { |ts| (ts.ending < starting) || (ts.starting > ending) }

      start_and_end = []
      first_bit = (time_speeds.first.starting - starting)
      last_bit  = (ending - time_speeds.last.ending)
      start_and_end << first_bit if first_bit.positive?
      start_and_end << last_bit if last_bit.positive?

      prev_ending = nil
      time_speeds_affected = time_speeds.each_with_object([]).with_index do |(ts, arr), i|
        starting = i == 0 ? [starting, ts.starting].max : ts.starting
        ending   = i == (time_speeds.length - 1) ? [ending, ts.ending].min : ts.ending

        # account for the ranges in between
        if prev_ending && (starting - prev_ending).positive?
          arr << (starting - prev_ending)
        end

        arr << (ending - starting) * ts.multiplier
        prev_ending = ending
      end

      pp time_speeds_affected

      [start_and_end, time_speeds_affected].flatten.sum
    end
  end
end