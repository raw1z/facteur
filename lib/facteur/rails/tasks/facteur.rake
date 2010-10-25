def obtain_class
  class_name = ENV['CLASS'] || ENV['class']
  raise "Must specify CLASS" unless class_name
  @klass = Object.const_get(class_name)
end

namespace :facteur do
  desc "Regenerates the mailboxes. The existing ones are not destroyed"
  task :update => :environment do
    klass = obtain_class
    klass.update_addressees_mailboxes
  end
end