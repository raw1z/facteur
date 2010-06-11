class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
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

  def self.down
    drop_table :messages
  end
end