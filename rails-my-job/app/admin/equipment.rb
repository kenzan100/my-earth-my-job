ActiveAdmin.register Equipment do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  permit_params :name, :hourly_rate, :timestamps, :status

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :name
      f.input :hourly_rate
      f.input :status
    end

    f.inputs do
      f.has_many :references, new_record: false do |t|
        t.input :url
      end
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end

  show do
    attributes_table do
      row :name
      row :hourly_rate
      row :status
      row :references do |equipment|
        equipment.references.map(&:url)
      end
    end
  end
end
