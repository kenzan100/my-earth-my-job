class PagesController < ApplicationController
  def main
    @equipments = Equipment.active
    @available_jobs = Equipment.proposed
    @current_val = Equipment.current_val(Time.now).round(2)
    @current_rate = Equipment.current_rate
  end
end
