require "test_helper"

class PersonTest < ActiveSupport::TestCase
  JobAttr = Struct.new(
    :name,
    :binary?,
    :required_months,
  )
  PersonAttr = Struct.new(
    :name,
    :spent_months,
  )

  setup do
    @job = Struct.new(
      :job_attributes,
    ).new(
      [
        JobAttr.new('Comm', true, nil),
        JobAttr.new('Coding', false, 20)
      ]
    )
  end

  test 'success is 0 if no person attr matches' do
    result = Person.new.success_rate(job: @job)
    assert_equal 0, result
  end

  test 'success detects binary person attr' do
    person_attrs = {
      'Comm' => 1000
    }
    result = Person.new(attrs: person_attrs).success_rate(job: @job)
    assert_equal 50, result
  end

  test 'success detects progressive person attr' do
    person_attrs = {
      'Non-Skill' => 1,
      'Comm' => 1,
      'Coding' => 10.months.to_i
    }
    result = Person.new(attrs: person_attrs).success_rate(job: @job)
    assert_equal 75, result.round
  end
end
