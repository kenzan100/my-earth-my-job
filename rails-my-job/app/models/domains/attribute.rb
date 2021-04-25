module Domains
  module Attribute
    def current_money_val(now)
      Equipment.all.reduce(0) do |sum, equipment|
        duration_sum = Domains::Time.new(now).total_active_duration(equipment.events_to_use)
        sum += duration_sum.to_f * (equipment.hourly_rate / 3600)
      end
    end
    module_function :current_money_val

    def current_good_attributes(now, good_attribute)
      good = good_attribute.good
      duration = Domains::Time.new(now).total_active_duration(good.events)
      (duration * good_attribute.hourly_rate) / 3600
    end
    module_function :current_good_attributes
  end
end