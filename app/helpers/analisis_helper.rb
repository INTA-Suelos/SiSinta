# encoding: utf-8
module AnalisisHelper
  def h_plus_label
    ("H." + content_tag(:sup, '+') + " de cambio").html_safe
  end

  def ca_co_3_label
    ("Ca CO" + content_tag(:sub, 3)).html_safe
  end
end
