require 'rake'
require 'rake/testtask'
require 'rdoc/task'

Rake::TestTask.new do |t|
  t.pattern = "spec/*/*_spec.rb"
end
