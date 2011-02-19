class User < ActiveRecord::Base
  include Facteur::AddresseeModel

  mailbox :private_mailbox, :default => true
  mailbox :public_mailbox
end
