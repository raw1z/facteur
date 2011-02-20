module Facteur
  if Object.const_defined? :ActiveRecord
    class Message < ActiveRecord::Base
      include Facteur::MessageModel
    end
    
  elsif Object.const_defined? :Mongoid
    class Message
      include Mongoid::Document
      include Facteur::MessageModel
    end
    
  else
    raise "Facteur only supports ActiveRecord and Mongoid"
  end
end