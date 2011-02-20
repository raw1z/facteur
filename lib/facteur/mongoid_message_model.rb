require 'mongoid'

module Facteur
  module MongoidMessageModel
    extend ActiveSupport::Concern

    included do
      field :body
      field :subject
      field :author_id
      
      embedded_in :mailbox, :class_name => "Facteur::Mailbox"
      referenced_in :author, :class_name => "User", :foreign_key => "author_id"
      
      #delegate :addressee, :to => :mailbox
      #delegate :addressee_type, :to => :mailbox
      validates_presence_of :body, :author_id
    end
  end
end

