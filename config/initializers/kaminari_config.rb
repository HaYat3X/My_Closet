# frozen_string_literal: true

Kaminari.configure do |config|
  config.default_per_page = 64
  config.max_per_page = 64
  config.window = 1
  # config.outer_window = 0
  # config.left = 0
  # config.right = 0
  # config.page_method_name = :page
  # config.param_name = :page
  # config.max_pages = 3
  # config.params_on_first_page = false
end
