class AddRateToAttributes < ActiveRecord::Migration[6.1]
  def change
    add_column :good_attributes, :hourly_rate, :integer
  end
end
