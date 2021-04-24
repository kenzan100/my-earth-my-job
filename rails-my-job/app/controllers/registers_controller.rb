class RegistersController < ApplicationController
  def create
    eq = Equipment.find(params['registerable'])
    now = Time.now
    Register.create!(
      start_hour: parse_time(now, 'starting'),
      end_hour:   parse_time(now, 'ending'),
      registerable_type: eq.class.to_s,
      registerable_id: eq.id
    )
    redirect_to root_path
  end

  private

  def parse_time(now, key)
    Time.utc(
      now.year,
      now.month,
      now.day,
      params.dig(key, 'hour'),
      params.dig(key, 'minute')
    )
  end
end