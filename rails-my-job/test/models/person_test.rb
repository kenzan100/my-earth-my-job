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
    person_attrs = [
      PersonAttr.new('Comm', 1)
    ]
    result = Person.new(attrs: person_attrs).success_rate(job: @job)
    assert_equal 50, result
  end

  test 'success detects progressive person attr' do
    person_attrs = [
      PersonAttr.new('Non-Skill', 1),
      PersonAttr.new('Comm', 1),
      PersonAttr.new('Coding', 10)
    ]
    result = Person.new(attrs: person_attrs).success_rate(job: @job)
    assert_equal 75, result
  end
end
