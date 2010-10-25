require File.join(File.dirname(__FILE__), 'facteur/message_model')
require File.join(File.dirname(__FILE__), 'facteur/mailbox_model')
require File.join(File.dirname(__FILE__), 'facteur/addressee_model')
require 'rails'

module Facteur
  module Rails
    class Railtie < ::Rails::Railtie
      rake_tasks do
        load "facteur/rails/tasks/facteur.rake"
      end
    end
  end
end
