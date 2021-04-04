ActiveAdmin.register Equipment do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  permit_params :name, :hourly_rate, :timestamps, :status,
                job_attributes_attributes:
                  [:name, :id, :required_months, :binary, :ditractor, :_destroy],
                events_attributes:
                  [:status_changed_to, :created_at, :id, :_destroy]

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :name
      f.input :hourly_rate
      f.input :status
    end

    f.inputs do
      f.has_many :events, allow_destroy: true do |t|
        t.input :status_changed_to
        t.input :created_at
      end
    end

    f.inputs do
      f.has_many :job_attributes, allow_destroy: true do |t|
        t.input :name
        t.input :required_months
        t.input :binary
        t.input :ditractor
      end
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
      row :job_attributes do |equipment|
        equipment.job_attributes.map(&:name)
      end
      row :events do |equipment|
        equipment.events.map do |ev|
          "#{ev.status}-#{ev.created_at}"
        end
      end
    end
  end
end
