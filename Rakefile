require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "facteur"
    gem.summary = "Messages managment system for Rails 3"
    gem.description = "Facteur allows you add a messages management system in your Rails 3. You can create many mailboxes for your users. They will be able to send and receive messages."
    gem.email = "dev@raw1z.fr"
    gem.homepage = "http://github.com/raw1z/facteur"
    gem.authors = ["Rawane ZOSSOU"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rspec/core'
require 'rspec/core/rake_task'
Rspec::Core::RakeTask.new(:spec) do |spec|
end

Rspec::Core::RakeTask.new(:rcov) do |spec|
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "facteur #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
