require 'active_support/concern'
require 'active_support/dependencies/autoload'

module Facteur
  extend ActiveSupport::Autoload
  
  autoload :ActiveRecordMessageModel
  autoload :MongoidMessageModel
  autoload :MessageModel
  autoload :ActiveRecordMailboxModel
  autoload :MongoidMailboxModel
  autoload :MailboxModel
  autoload :BaseAddresseeModel
  autoload :ActiveRecordAddresseeModel
  autoload :MongoidAddresseeModel
  autoload :AddresseeModel
end