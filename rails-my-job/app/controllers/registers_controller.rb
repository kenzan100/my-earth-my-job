class RegistersController < ApplicationController
  def create
    # TODO: Don't trust the params in production
    eq = PolymorphicSelectable.find_polymorphic_selectable(params['registerable'])
    now = Time.now

    register = Register.new(
      start_hour: parse_time(now, 'starting'),
      end_hour:   parse_time(now, 'ending'),
      registerable_type: eq.class.to_s,
      registerable_id: eq.id
    )

    if register.overlaps?
      redirect_to root_path, notice: "Cannot create an overlapping schedule."
      return
    end

    if register.end_hour <= register.start_hour
      redirect_to root_path, notice: "Schedule range is less than 0."
      return
    end

    register.save!
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