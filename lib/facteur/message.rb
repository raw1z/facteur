module Facteur
  class Message < ActiveRecord::Base
    include Facteur::MessageModel
  end
end