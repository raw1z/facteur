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
  
  def self.addressee_model
    @addressee_model || "User"
  end
  
  def self.addressee_model=(model)
    @addressee_model = model
  end
end