module Facteur
  module AddresseeModel
    extend ActiveSupport::Concern

    included do
      Facteur.send(:remove_const, :Mailbox) if Facteur.const_defined?(:Mailbox)
      Facteur.send(:remove_const, :Message) if Facteur.const_defined?(:Message)
      
      if self.ancestors.map(&:to_s).include?("ActiveRecord::Base")
        
        Facteur.const_set(:Mailbox, Class.new(ActiveRecord::Base))
        Facteur::Mailbox.class_exec do
          include Facteur::ActiveRecordMailboxModel
        end

        Facteur.const_set(:Message, Class.new(ActiveRecord::Base))
        Facteur::Message.class_exec do
          include Facteur::ActiveRecordMessageModel
        end
        
        include Facteur::ActiveRecordAddresseeModel
      
      elsif self.ancestors.map(&:to_s).include?("Mongoid::Document")
        
        Facteur.const_set(:Mailbox, Class.new)
        Facteur::Mailbox.class_exec do
          include Mongoid::Document
          include Facteur::MongoidMailboxModel
        end

        Facteur.const_set(:Message, Class.new)
        Facteur::Message.class_exec do
          include Mongoid::Document
          include Facteur::MongoidMessageModel
        end
        
        include Facteur::MongoidAddresseeModel
        
      else
        raise "Facteur only supports ActiveRecord and Mongoid"
      end
    end
  end
end
