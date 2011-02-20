require 'mongoid'

module Facteur
  module MongoidAddresseeModel
    include Facteur::BaseAddresseeModel
    extend ActiveSupport::Concern

    included do
      embeds_many :mailboxes, :class_name => "Facteur::Mailbox"
    end
  end
end
