class DomainsMoneyTest < ActiveSupport::TestCase
  test 'duration respect the oldest active event if duplicate active' do
    eq = Equipment.new
    eq.events.build(created_at: 2.days.ago, status: :stopped)
    eq.events.build(created_at: 1.day.ago, status: :active)
    eq.events.build(created_at: 10.hours.ago, status: :active)

    res = Domains::Time.new(Time.now).total_active_duration(eq)
    assert_equal 1.day.to_i, res.round
  end

  test 'duration tracks multiple start and stop events' do
    eq = Equipment.new
    eq.events.build(created_at: 24.hours.ago, status: :active)
    eq.events.build(created_at: 22.hours.ago, status: :stopped)
    eq.events.build(created_at: 20.hours.ago, status: :active)
    eq.events.build(created_at: 11.hours.ago, status: :stopped)
    eq.events.build(created_at: 10.hours.ago, status: :active)

    res = Domains::Time.new(Time.now).total_active_duration(eq)
    assert_equal 21.hours.to_i, res.round
  end

  test 'duration can accept TimeSpeed with ending nil' do
    eq = Equipment.new
    # if not timespeed, 10 days
    eq.events.build(created_at: 11.days.ago, status: :active)
    eq.events.build(created_at: 1.day.ago, status: :stopped)

    time_speeds = [
      TimeSpeed.new(starting: 15.days.ago, ending: 10.days.ago, multiplier: 2),
      TimeSpeed.new(starting: 2.days.ago, ending: nil, multiplier: 3),
    ]

    res = Domains::Time.new(Time.now, time_speeds: time_speeds).total_active_duration(eq)

    expected = (1.day * 2) + (1.days * 3) + (8.days)
    assert_equal expected.to_i, res.round
  end

  test 'XYZ duration takes into account of TimeSpeed' do
    eq = Equipment.new
    # if not timespeed, 10 days
    eq.events.build(created_at: 11.days.ago, status: :active)
    eq.events.build(created_at: 1.day.ago, status: :stopped)

    speed_changes = [
      TimeSpeed.new(starting: 15.days.ago, ending: 10.days.ago,       multiplier: 2),
      TimeSpeed.new(starting: 8.days.ago,  ending: 6.days.ago,        multiplier: 3),
      TimeSpeed.new(starting: 2.days.ago,  ending: Time.now + 2.days, multiplier: 4),
    ]
    res = Domains::Time.new(Time.now, time_speeds: speed_changes).total_active_duration(eq)

    # 1 day  of speeding at 2x (11 days ago ~ 10 days ago)
    # 2 days of speeding at 3x (8 days ago ~ 6 days ago)
    # 1 day  of speedign at 4x (2 days ago ~ 1 day ago)
    # 6 days of normal speed (1x speed)

    expected = (1.day * 2) + (2.days * 3) + (1.day * 4) + (6.days)
    assert_equal expected.to_i, res.round
  end
end


