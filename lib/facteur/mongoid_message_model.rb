require 'mongoid'

module Facteur
  module MongoidMessageModel
    extend ActiveSupport::Concern

    included do
      field :body
      field :subject
      
      embedded_in :mailbox, :class_name => "Facteur::Mailbox"
      referenced_in :author, :class_name => Facteur.addressee_model
      references_and_referenced_in_many :addressees, :class_name => Facteur.addressee_model
      
      validates_presence_of :body, :author_id
    end
  end
end

