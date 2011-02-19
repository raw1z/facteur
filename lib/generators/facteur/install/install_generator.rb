require 'rails/generators'
require 'rails/generators/migration'

module Facteur
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      def self.source_root
        @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
      end

      def self.next_migration_number
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      end

      desc "Generate the facteur's message and mailbox models"
      def create_facteur_files
        template 'message.rb', 'app/models/message.rb'
        template 'create_messages.rb', "db/migrate/#{self.class.next_migration_number}_create_messages.rb"
        
        sleep(1)
        template 'mailbox.rb', 'app/models/mailbox.rb'
        template 'create_mailboxes.rb', "db/migrate/#{self.class.next_migration_number}_create_mailboxes.rb"
      end
    end
  end
end
