class PagesController < ApplicationController
  before_action :set_registerables

  def main
    now = Time.now

    @equipments = Equipment.active
    @available_jobs = Equipment.proposed
    @current_val = Domains::Money.current_val(now).round(2) - Spend.total
    @current_rate = Equipment.current_rate
    @running_speed = TimeSpeed.find_by(ending: nil)&.multiplier || 1

    @skills = Equipment.skills_acquired(now)
  end

  def calendar
  end

  private

  def set_registerables
    @registerables = Equipment.active
  end
end
