Kaminari.configure do |config|
  config.default_per_page = 20
  config.window = 1
  # config.outer_window = 0
  # config.left = 0
  # config.right = 0
  config.page_method_name = :pagina
  config.param_name = :pagina
end
