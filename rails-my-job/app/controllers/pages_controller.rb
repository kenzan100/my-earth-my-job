class PagesController < ApplicationController
  before_action :set_registerables

  def main
    now = Time.now

    @equipments = Equipment.active
    @available_jobs = Equipment.proposed
    @current_val = Domains::Money.current_val(now).round(2) - Spend.total
    @current_rate = Equipment.current_rate

    @zone = ActiveSupport::TimeZone.new('Eastern Time (US & Canada)')
    @running_speed = TimeSpeed.find_by(ending: nil)&.multiplier || 1
    @game_time = Domains::Time.new(now).overall_game_time

    @skills = Equipment.skills_acquired(now)
  end

  def calendar
  end

  private

  def set_registerables
    @registerables = Equipment.active
  end
end
