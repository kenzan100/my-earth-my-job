ActiveAdmin.register Equipment do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :hourly_rate, :timestamps
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :hourly_rate, :timestamps]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
