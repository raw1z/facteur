module Facteur
  if Object.const_defined? :ActiveRecord
    class Mailbox < ActiveRecord::Base
      include Facteur::MailboxModel
      attr_accessible :name # stops ActiveRecord mass_assignment issues;
                            #it appears this is the only attr that is directly set when a message is sent
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