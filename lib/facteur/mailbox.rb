module Facteur
  if Object.const_defined? :ActiveRecord
    class Mailbox < ActiveRecord::Base
      include Facteur::MailboxModel
      attr_accessible :name #allows name attribute to be accessed in rails 3.2 +
    end
    
  elsif Object.const_defined? :Mongoid
    class Mailbox
      include Mongoid::Document
      include Facteur::MailboxModel
    end
    
  else
    raise "Facteur only supports ActiveRecord and Mongoid"
  end
end