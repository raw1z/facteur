$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rspec'
require 'active_record'
require 'logger'
require 'facteur'

SPEC_ROOT = File.dirname(__FILE__)

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => ":memory:"
)

ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do
  create_table :users, :force => true do |t|
    t.string :name, :null => false
  end

  create_table :mailboxes, :force => true do |t|
    t.string :name
    t.text :contents
    t.integer :addressee_id
    t.string :addressee_type
    t.boolean :default
  end
  
  create_table :messages, :force => true do |t|
    t.string    :subject
    t.text      :body
    t.integer   :mailbox_id
    t.integer   :author_id
    t.boolean   :deleted_by_author, :default => false
    t.datetime  :deleted_by_author_at
    t.boolean   :deleted_by_addressee, :default => false
    t.datetime  :deleted_by_addressee_at
    t.boolean   :read, :default => false
  end
end

#ActiveRecord::Base.logger = Logger.new(File.open("#{SPEC_ROOT}/db/database.log", 'a'))

class User < ActiveRecord::Base
  include Facteur::AddresseeModel
  
  mailbox :private_mailbox, :default => true
  mailbox :public_mailbox
end

class Mailbox < ActiveRecord::Base
  include Facteur::MailboxModel
end

class Message < ActiveRecord::Base
  include Facteur::MessageModel 
end

def create_users
  User.delete_all
  Mailbox.delete_all
  %w(John Peter James Mary Jane Victoria).each do |name|
    eval "@#{name.downcase} = User.create(:name => '#{name}')"
  end
end

