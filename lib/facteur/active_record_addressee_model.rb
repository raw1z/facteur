require 'active_record'

module Facteur
  module ActiveRecordAddresseeModel
    include Facteur::BaseAddresseeModel
    extend ActiveSupport::Concern

    included do
      has_many :mailboxes, :as => :addressee, :class_name => "Facteur::Mailbox"
    end
  end
end
