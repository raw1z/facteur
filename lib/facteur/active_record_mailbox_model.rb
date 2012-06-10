require 'active_record'

module Facteur
  module ActiveRecordMailboxModel
    extend ActiveSupport::Concern

    included do
      belongs_to :addressee, :polymorphic => true
      has_many :messages, :class_name => "Facteur::Message"
      attr_accessible :name #allows name to be accessible in rails 3.2+

      validates_presence_of :name
      validates_uniqueness_of :name, :scope => [:addressee_id, :addressee_type]
    end
  end
end
