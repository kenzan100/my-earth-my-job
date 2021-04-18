class DomainsMoneyTest < ActiveSupport::TestCase
  test 'duration respect the oldest active event if duplicate active' do
    eq = Equipment.new
    eq.events.build(created_at: 2.days.ago, status: :stopped)
    eq.events.build(created_at: 1.day.ago, status: :active)
    eq.events.build(created_at: 10.hours.ago, status: :active)

    res = Domains::Time.total_active_duration(eq, Time.now, overrides: eq.events)
    assert_equal 1.day.to_i, res.round
  end

  test 'duration tracks multiple start and stop events' do
    eq = Equipment.new
    eq.events.build(created_at: 24.hours.ago, status: :active)
    eq.events.build(created_at: 22.hours.ago, status: :stopped)
    eq.events.build(created_at: 20.hours.ago, status: :active)
    eq.events.build(created_at: 11.hours.ago, status: :stopped)
    eq.events.build(created_at: 10.hours.ago, status: :active)

    res = Domains::Time.total_active_duration(eq, Time.now, overrides: eq.events)
    assert_equal 21.hours.to_i, res.round

  end
end


