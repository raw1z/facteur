require 'mongoid'

module Facteur
  module MongoidMailboxModel
    extend ActiveSupport::Concern

    included do
      field :name
      field :default, :default => false
      
      embedded_in :addressee, :class_name => Facteur.addressee_model, :inverse_of => :mailboxes
      embeds_many :messages, :class_name => "Facteur::Message"
      
      validates_uniqueness_of :name
      validates_presence_of :name
    end
  end
end
