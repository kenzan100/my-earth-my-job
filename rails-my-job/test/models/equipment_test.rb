require "test_helper"

class EquipmentTest < ActiveSupport::TestCase
  test 'skills_acquired returns job attrs accumulated by duration' do
    eq = Equipment.new
    ja = JobAttribute.new(name: 1, required_months: 10, binary: false)
    eq.job_attributes << ja
    eq.events.build(created_at: 24.hours.ago, status: :active)
    eq.events.build(created_at: 22.hours.ago, status: :stopped)
    eq.events.build(created_at: 20.hours.ago, status: :active)
    eq.events.build(created_at: 11.hours.ago, status: :stopped)
    eq.events.build(created_at: 10.hours.ago, status: :active)

    res = eq.skills_acquired(Time.now)
    res.transform_values! { |v| v.round }
    assert_equal({ "1" => 75600 }, res)
  end
end
