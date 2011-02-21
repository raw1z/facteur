require 'mongoid'

module Facteur
  module MongoidMessageModel
    extend ActiveSupport::Concern

    included do
      field :body
      field :subject
      
      embedded_in :mailbox, :class_name => "Facteur::Mailbox"
      referenced_in :author, :class_name => "User"
      references_and_referenced_in_many :addressees, :class_name => "User"
      
      validates_presence_of :body, :author_id
    end
  end
end

