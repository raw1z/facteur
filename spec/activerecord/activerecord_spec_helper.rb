require 'spec_helper'
require 'active_record'
Dir[File.expand_path('../../support/activerecord/*.rb', __FILE__)].each{|f| require f }

RSpec.configure do |c|
  c.before(:suite) do
    CreateSchema.suppress_messages{ CreateSchema.migrate(:up) }
  end

  c.before(:each) do
    User.delete_all
    Facteur::Mailbox.delete_all
    Facteur::Message.delete_all
    
    %w(John Peter James Mary Jane Victoria).each do |name|
      instance_variable_set("@#{name.downcase}".to_sym, User.create(:name => name))
    end
  end
end

