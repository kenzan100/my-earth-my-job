ActiveAdmin.register Event do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :status_changed_to, :eventable_id, :eventable_type

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :status_changed_to
      f.input :eventable, collection: Equipment.all + Good.all
      f.input :eventable_type
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end

  #
  # or
  #
  # permit_params do
  #   permitted = [:status_changed_to, :equipment_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
