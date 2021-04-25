module PolymorphicSelectable
  def polymorphic_select_option_id
    [self.class, id].join("-")
  end

  def find_polymorphic_selectable(select_option_id)
    klass, id = select_option_id.split("-")
    klass.safe_constantize.find(id)
  end

  module_function :find_polymorphic_selectable
end