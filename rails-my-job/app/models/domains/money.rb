module Domains
  module Money
    def current_val(now)
      Equipment.all.reduce(0) do |sum, equipment|
        duration_sum = Domains::Time.total_active_duration(equipment, now)
        sum += duration_sum.to_f * (equipment.hourly_rate / 3600)
      end
    end
    module_function :current_val
  end
end