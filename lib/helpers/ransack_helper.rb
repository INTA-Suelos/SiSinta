# encoding: utf-8
module RansackHelper
  # Construye el formulario de búsqueda inicial
  def setup_search_form(f)
    content_tag(:script, type: 'text/html', class: 'agrupamiento template') do
      f.grouping_fields f.object.new_grouping, object_name: 'new_object_name', child_index: "new_grouping" do |ff|
        render('grouping_fields', f: ff)
      end
    end
  end

  def button_to_remove_fields(name, f)
    content_tag :button, name, class: 'remove_fields'
  end

  def button_to_add_fields(name, f, type)
    new_object = f.object.send "build_#{type}"
    fields = f.send("#{type}_fields", new_object, child_index: "new_#{type}") do |builder|
      render(type.to_s + "_fields", f: builder)
    end
    content_tag :button, name, :class => 'add_fields', 'data-field-type' => type, 'data-content' => "#{fields}"
  end

  def button_to_nest_fields(name, type)
    content_tag :button, name, :class => 'nest_fields', 'data-field-type' => type
  end
end
