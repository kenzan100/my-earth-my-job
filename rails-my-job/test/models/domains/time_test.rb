class DomainsMoneyTest < ActiveSupport::TestCase
  test 'duration respect the oldest active event if duplicate active' do
    eq = Equipment.new
    eq.events.build(created_at: 2.days.ago, status: :stopped)
    eq.events.build(created_at: 1.day.ago, status: :active)
    eq.events.build(created_at: 10.hours.ago, status: :active)

    res = Domains::Time.new(eq).total_active_duration(Time.now, overrides: { Event => eq.events })
    assert_equal 1.day.to_i, res.round
  end

  test 'duration tracks multiple start and stop events' do
    eq = Equipment.new
    eq.events.build(created_at: 24.hours.ago, status: :active)
    eq.events.build(created_at: 22.hours.ago, status: :stopped)
    eq.events.build(created_at: 20.hours.ago, status: :active)
    eq.events.build(created_at: 11.hours.ago, status: :stopped)
    eq.events.build(created_at: 10.hours.ago, status: :active)

    res = Domains::Time.new(eq).total_active_duration(Time.now, overrides: { Event => eq.events })
    assert_equal 21.hours.to_i, res.round
  end

  test 'duration takes into account of TimeSpeed' do
    eq = Equipment.new
    # if not timespeed, 10 days
    eq.events.build(created_at: 11.days.ago, status: :active)
    eq.events.build(created_at: 1.day.ago, status: :stopped)

    speed_changes = [
      TimeSpeed.new(starting: 15.days.ago, ending: 10.days.ago,       multiplier: 2),
      TimeSpeed.new(starting: 8.days.ago,  ending: 6.days.ago,        multiplier: 3),
      TimeSpeed.new(starting: 2.days.ago,  ending: Time.now + 2.days, multiplier: 4),
    ]
    res = Domains::Time.new(eq).total_active_duration(
      Time.now,
      overrides: {
        Event => eq.events,
        TimeSpeed => speed_changes
      }
    )

    assert_equal 0, res.round
  end
end


