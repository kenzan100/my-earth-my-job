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

    PointInTime = Struct.new(:timestamp, :starting_type, :stopping_type, :multiplier)

    def destructure(time_speeds)
      time_speeds.flat_map do |ts|
        [
          PointInTime.new(ts.starting, true, true, ts.multiplier),
          PointInTime.new(ts.ending, true, true, 1)
        ]
      end
    end

    def game_time(starting, ending, time_speeds)
      return (ending - starting) if time_speeds.empty?

      starting = PointInTime.new(starting, true, false, 1)
      ending =   PointInTime.new(ending, false, true, 1)

      if time_speeds.first && time_speeds.first.ending.between?(starting.timestamp, ending.timestamp)
        starting.multiplier = time_speeds.first.multiplier
      end

      points_in_time = (destructure(time_speeds) + [starting, ending]).sort_by(&:timestamp)
      points_in_time.reject! do |pit|
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