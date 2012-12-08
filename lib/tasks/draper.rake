# https://github.com/drapergem/draper/blob/087e134ed0885ec11325ffabe8ab2bebef77a33a/lib/draper/test/test_unit_integration.rb
require "rake/testtask"
require "rails/test_unit/sub_test_task"

namespace :test do
  Rails::SubTestTask.new(:decorators => "test:prepare") do |t|
    t.libs << "test"
    t.pattern = "test/decorators/**/*_test.rb"
  end
end

# FIXME Enganchar test:decorators con test:run
# Esto debería andar, pero...
Rake::Task["test:run"].enhance do
  Rake::Task["test:decorators"].invoke
end
