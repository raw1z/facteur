module Facteur
  module ActiveRecordMessageModel
    extend ActiveSupport::Concern

    included do
      validates_presence_of :author_id, :mailbox_id, :body

      belongs_to :mailbox, :class_name => "Facteur::Mailbox"
      belongs_to :author, :class_name => "User", :foreign_key => "author_id"

      delegate :addressee, :to => :mailbox
      delegate :addressee_type, :to => :mailbox
    end
  end
end

