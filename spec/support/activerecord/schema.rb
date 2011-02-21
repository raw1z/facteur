ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => ":memory:"
)

class CreateSchema < ActiveRecord::Migration
  def self.up
    create_table :users, :force => true do |t|
      t.string :name, :null => false
    end

    create_table :mailboxes, :force => true do |t|
      t.string     :name
      t.belongs_to :addressee, :polymorphic => true
      t.boolean    :default, :default => :false
    end

    create_table :messages, :force => true do |t|
      t.string     :subject
      t.text       :body
      t.belongs_to :mailbox
      t.belongs_to :author
      t.boolean    :read, :default => false
    end
    
    create_table :messages_addressees, :id => false, :force => true do |t|
      t.references :addressee
      t.references :message
    end
  end
end

