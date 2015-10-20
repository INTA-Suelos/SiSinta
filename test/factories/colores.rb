# encoding: utf-8
FactoryGirl.define do
  factory :color, aliases: [:color_seco, :color_humedo] do
    hvc { "#{rand(9999)}B 1/1" }
    rgb { "rgb(#{rand(255)}, 30, 36)" }
  end
end
