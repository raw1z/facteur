module Facteur
  module MailboxModel
    def self.included(receiver)
      receiver.class_exec do
        belongs_to :addressee, :polymorphic => true
        has_many :messages
        validates_presence_of :name
        validates_uniqueness_of :name, :scope => [:addressee_id, :addressee_type]
      end
    end
  end
end
