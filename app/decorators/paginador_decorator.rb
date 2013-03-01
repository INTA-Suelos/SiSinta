# encoding: utf-8
class PaginadorDecorator < Draper::CollectionDecorator
  delegate :current_page, :total_pages, :limit_value, :total_count, :pagina
end
