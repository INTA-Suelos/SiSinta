# Reemplazo el proc que marca los campos con error para especificar si encierra
# un label o al campo de entrada.
# El archivo es actionpack/lib/action_view/base.rb
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  clase = (html_tag =~ /label/) ? 'error_label' : 'error_field'
  "<div class=\"field_with_errors #{clase}\">#{html_tag}</div>".html_safe
end
