module Facteur
  module MessageModel
    def self.included(receiver)
      receiver.class_exec do
        validates_presence_of :author_id, :mailbox_id, :body

        belongs_to :mailbox
        belongs_to :author, :class_name => "User", :foreign_key => "author_id"

        delegate :addressee, :to => :mailbox
        delegate :addressee_type, :to => :mailbox
      end
    end
  end
end

