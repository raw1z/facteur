module Facteur
  module MailboxModel
    extend ActiveSupport::Concern

    included do
      if self.ancestors.map(&:to_s).include?("ActiveRecord::Base")
        self.class_exec { include Facteur::ActiveRecordMailboxModel }
      elsif self.ancestors.map(&:to_s).include?("Mongoid::Document")
        self.class_exec { include Facteur::MongoidMailboxModel }
      else
        raise "Facteur only supports ActiveRecord and Mongoid"
      end
    end
  end
end
