ActiveAdmin.register Reference do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :url, :referencible_type, :referencible_id

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :url
      f.input :referencible, collection: Equipment.all
      f.input :referencible_type, input_html: { value: "Equipment" }
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:url, :referencible_type, :referencible_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
