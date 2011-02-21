require 'active_record'

module Facteur
  module ActiveRecordMessageModel
    extend ActiveSupport::Concern

    included do
      validates_presence_of :author_id, :mailbox_id, :body

      belongs_to :mailbox,
                 :class_name => "Facteur::Mailbox"
      
      belongs_to :author,
                 :class_name => "User",
                 :foreign_key => "author_id"
                 
      has_and_belongs_to_many :addressees, 
                              :class_name => "User",
                              :join_table => "messages_addressees",
                              :association_foreign_key => "addressee_id"
    end
  end
end

