class PagesController < ApplicationController
  def main
    now = Time.now

    @equipments = Equipment.active
    @available_jobs = Equipment.proposed
    @current_val = Equipment.current_val(now).round(2) - Spend.total
    @current_rate = Equipment.current_rate
    @skills = Equipment.skills_acquired(now)
  end
end
