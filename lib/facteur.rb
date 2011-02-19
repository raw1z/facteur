require 'active_support/concern'
require 'active_support/dependencies/autoload'
require 'active_record'

module Facteur
  extend ActiveSupport::Autoload
  
  autoload :ActiveRecordMessageModel
  autoload :ActiveRecordMailboxModel
  autoload :BaseAddresseeModel
  autoload :ActiveRecordAddresseeModel
  autoload :MessageModel
  autoload :MailboxModel
  autoload :AddresseeModel
  autoload :Message
  autoload :Mailbox
end