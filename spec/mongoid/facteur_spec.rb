require File.expand_path(File.dirname(__FILE__) + '/mongoid_spec_helper')

describe Facteur::AddresseeModel do
  context "When users are created after activating facteur" do
    before(:all) do
      # create a user model with facteur activated
      Object.send(:remove_const, :User) if Object.const_defined?(:User)
      User = Class.new
      User.class_exec do
        include Mongoid::Document
        include Facteur::AddresseeModel
        field :name, :require => true
        mailbox :private_mailbox, :default => true
        mailbox :public_mailbox
      end
      
      # create the users
      User.delete_all
      create_users
    end
  
    it_should_behave_like "an addressee model"
  end
  
  context "When users are created before activating facteur" do
    before(:all) do
      # create a user model without amistad activated
      Object.send(:remove_const, :User) if Object.const_defined?(:User)
      User = Class.new
      User.class_exec do
        include Mongoid::Document
        field :name, :require => true
      end
      
      # create the users
      User.delete_all
      create_users
      
      # activate facteur
      User.class_exec do
        include Facteur::AddresseeModel
        mailbox :private_mailbox, :default => true
        mailbox :public_mailbox
      end
    end
  
    it_should_behave_like "an addressee model"
  end
end