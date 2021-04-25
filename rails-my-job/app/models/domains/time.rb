module Domains
  class Time
    attr_reader :now, :time_speeds

    def initialize(now, time_speeds: nil)
      @now = now
      @time_speeds = time_speeds&.sort_by(&:starting) || TimeSpeed.order(:starting)
    end

    def overall_game_time
      game_start = Equipment.minimum(:created_at)
      elapsed = game_time(game_start, now)
      game_start + elapsed.seconds
    end

    def total_active_duration(equipment)
      started = nil
      events_to_use = equipment.events_to_use

      # event: created_at, active|stopped
      diffs = events_to_use.each_with_object([]) do |ev, arr|
        started = ev.created_at if ev.active? && started.nil?
        if ev.stopped? && started
          arr << game_time(started, ev.created_at)
          started = nil
        end
      end

      diffs << game_time(started, now) if started

      diffs.sum
    end

    private

    PointInTime = Struct.new(:timestamp, :starting_type, :stopping_type, :multiplier)

    def destructured_time_speeds
      time_speeds.flat_map do |ts|
        [
          PointInTime.new(ts.starting, true, true, ts.multiplier),
          PointInTime.new(ts.ending, true, true, 1)
        ]
      end
    end

    def game_time(starting, ending)
      return (ending - starting) if time_speeds.empty?

      starting = PointInTime.new(starting, true, false, 1)
      ending =   PointInTime.new(ending, false, true, 1)

      # if the boost time predates the beginning of event time, use that multiplier first
      if time_speeds.first.affects?(starting.timestamp)
        starting.multiplier = time_speeds.first.multiplier
      end

      points_in_time = (destructured_time_speeds + [starting, ending]).sort_by { |pit| pit.timestamp.to_i || Float::INFINITY }
      points_in_time.reject! do |pit|
        next true if pit.timestamp.nil?
        pit.timestamp < starting.timestamp || pit.timestamp > ending.timestamp
      end

      started = nil
      durations = points_in_time.each_with_object([]) do |pit, arr|
        if started.nil? && pit.starting_type
          started = pit
          next
        end

        if started && pit.stopping_type
          arr << (pit.timestamp - started.timestamp) * started.multiplier
          started = pit.starting_type ? pit : nil
        end
      end

      if started && started != ending
        durations << (ending.timestamp - started.timestamp) * started.multiplier
      end

      durations.sum
    end
  end
end