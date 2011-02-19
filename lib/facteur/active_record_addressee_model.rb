module Facteur
  module ActiveRecordAddresseeModel
    include Facteur::BaseAddresseeModel
    extend ActiveSupport::Concern

    included do
      has_many :mailboxes, :as => :addressee, :class_name => "Facteur::Mailbox"
      has_many :messages_sent, :class_name => "Facteur::Message", :foreign_key => "author_id"

      # the addressee's mailboxes are created after its creation
      after_create :create_mailboxes
    end
  end
end
