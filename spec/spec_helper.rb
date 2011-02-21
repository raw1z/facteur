require 'rspec'
require 'awesome_print'
require 'facteur'
Dir["#{File.dirname(__FILE__)}/support/*.rb"].each {|f| require f}

def create_users
  %w(John Peter James Mary Jane Victoria).each do |name|
    instance_variable_set("@#{name.downcase}".to_sym, Member.create(:name => name))
  end
end
