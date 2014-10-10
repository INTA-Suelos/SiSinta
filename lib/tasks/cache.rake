# encoding: utf-8
namespace :cache do
  desc 'Limpia el cache de rails'
  task :clear => :environment do
    Rails.cache.clear
  end
end
