class CreateMailboxes < ActiveRecord::Migration
  def self.up
    create_table :mailboxes do |t|
      t.string :name
      t.text :contents
      t.integer :addressee_id
      t.string :addressee_type
      t.boolean :default
    end
  end

  def self.down
    drop_table :mailboxes
  end
end