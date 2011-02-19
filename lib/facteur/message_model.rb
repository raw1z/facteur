module Facteur
  module MessageModel
    extend ActiveSupport::Concern

    included do
      if self.ancestors.map(&:to_s).include?("ActiveRecord::Base")
        self.class_exec { include Facteur::ActiveRecordMessageModel }
      elsif self.ancestors.map(&:to_s).include?("Mongoid::Document")
        self.class_exec { include Facteur::MongoidMessageModel }
      else
        raise "Facteur only supports ActiveRecord and Mongoid"
      end
    end
  end
end

