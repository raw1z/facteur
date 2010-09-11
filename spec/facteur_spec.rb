require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Facteur::AddresseeModel do
  context "when creating mailboxes" do
    before(:each) do
      create_users
      Message.delete_all
    end
    
    it "creates a new mailbox" do
      @john.create_mailbox(:news_mailbox).should == true
      
      lambda { @peter.create_mailbox! :news_mailbox }.should_not raise_error
      
      mailbox = @victoria.create_mailbox! :news_mailbox
      mailbox.addressee.should == @victoria
    end
    
    it "could not create a mailbox with the name of an existing mailbox" do
      @john.create_mailbox(:private_mailbox).should == false
      lambda { mailbox = @peter.create_mailbox! :private_mailbox }.should raise_error
    end
  end
  
  context "when initialized" do
    before(:each) do
      create_users
      Message.delete_all
    end
    
    it "creates the addressee's mailboxes" do
      @john.mailboxes.where(:name => 'private_mailbox').first.should_not be_nil
      @john.mailboxes.where(:name => 'public_mailbox').first.should_not be_nil
      
      @peter.mailboxes.where(:name => 'private_mailbox').first.should_not be_nil
      @peter.mailboxes.where(:name => 'public_mailbox').first.should_not be_nil
      
      @james.mailboxes.where(:name => 'private_mailbox').first.should_not be_nil
      @james.mailboxes.where(:name => 'public_mailbox').first.should_not be_nil
      
      @mary.mailboxes.where(:name => 'private_mailbox').first.should_not be_nil
      @mary.mailboxes.where(:name => 'public_mailbox').first.should_not be_nil
      
      @jane.mailboxes.where(:name => 'private_mailbox').first.should_not be_nil
      @jane.mailboxes.where(:name => 'public_mailbox').first.should_not be_nil
      
      @victoria.mailboxes.where(:name => 'private_mailbox').first.should_not be_nil
      @victoria.mailboxes.where(:name => 'public_mailbox').first.should_not be_nil
    end
    
    it "defines the mailboxes accessors" do
      @john.should respond_to :private_mailbox
      @john.should respond_to :public_mailbox
      @john.private_mailbox.should_not be_nil
      @john.public_mailbox.should_not be_nil
      
      @peter.should respond_to :private_mailbox
      @peter.should respond_to :public_mailbox
      @peter.private_mailbox.should_not be_nil
      @peter.public_mailbox.should_not be_nil
      
      @james.should respond_to :private_mailbox
      @james.should respond_to :public_mailbox
      @james.private_mailbox.should_not be_nil
      @james.public_mailbox.should_not be_nil
      
      @mary.should respond_to :private_mailbox
      @mary.should respond_to :public_mailbox
      @mary.private_mailbox.should_not be_nil
      @mary.public_mailbox.should_not be_nil
      
      @jane.should respond_to :private_mailbox
      @jane.should respond_to :public_mailbox
      @jane.private_mailbox.should_not be_nil
      @jane.public_mailbox.should_not be_nil
      
      @victoria.should respond_to :private_mailbox
      @victoria.should respond_to :public_mailbox
      @victoria.private_mailbox.should_not be_nil
      @victoria.public_mailbox.should_not be_nil
    end
  end
  
  context "When adding a new mailbox" do
    before(:all) do
      create_users
      class User < ActiveRecord::Base
        mailbox :added_mailbox
      end
      User.update_addressees_mailboxes
    end
    
    it "should add the new mailbox to the class mailboxes" do
      User.mailboxes.should include({:name=>:added_mailbox})
    end
    
    it "should add the new mailbox to all the existing users" do
      @john.mailboxes.where(:name => 'private_mailbox').first.should_not be_nil
      @john.mailboxes.where(:name => 'public_mailbox').first.should_not be_nil
      @john.mailboxes.where(:name => 'added_mailbox').first.should_not be_nil
      
      @peter.mailboxes.where(:name => 'private_mailbox').first.should_not be_nil
      @peter.mailboxes.where(:name => 'public_mailbox').first.should_not be_nil
      @peter.mailboxes.where(:name => 'added_mailbox').first.should_not be_nil
      
      @james.mailboxes.where(:name => 'private_mailbox').first.should_not be_nil
      @james.mailboxes.where(:name => 'public_mailbox').first.should_not be_nil
      @james.mailboxes.where(:name => 'added_mailbox').first.should_not be_nil
      
      @mary.mailboxes.where(:name => 'private_mailbox').first.should_not be_nil
      @mary.mailboxes.where(:name => 'public_mailbox').first.should_not be_nil
      @mary.mailboxes.where(:name => 'added_mailbox').first.should_not be_nil
      
      @jane.mailboxes.where(:name => 'private_mailbox').first.should_not be_nil
      @jane.mailboxes.where(:name => 'public_mailbox').first.should_not be_nil
      @jane.mailboxes.where(:name => 'added_mailbox').first.should_not be_nil
      
      @victoria.mailboxes.where(:name => 'private_mailbox').first.should_not be_nil
      @victoria.mailboxes.where(:name => 'public_mailbox').first.should_not be_nil
      @victoria.mailboxes.where(:name => 'added_mailbox').first.should_not be_nil
    end
  end
  
  context "when sending message" do
    before(:each) do
      create_users
      Message.delete_all
    end
    
    it "sends a message to another addressee" do
      @john.send_message('message contents', :to => @peter, :in => :private_mailbox).should == true
      message = @peter.private_mailbox.messages.last
      message.author.should == @john
      message.body.should == 'message contents'
    end
    
    it "sends the messages in the default mailbox" do
      @john.send_message('message contents', :to => @peter).should == true
      message = @peter.private_mailbox.messages.last
      message.author.should == @john
      message.body.should == 'message contents'
    end
    
    it "could not send a message if the addressee is not given" do
      @john.send_message('message contents', :in => :private_mailbox).should == false
    end
    
    it "raises an error if the mailbox name given is unknown" do
      lambda{ @john.send_message('message contents', :to => @peter, :in => :unknown_mailbox) }.should raise_error
    end
    
    it "sends a message to many addressees" do
      @john.send_message('message contents', :to => [@peter, @james, @jane], :in => :private_mailbox)
      
      message = @peter.private_mailbox.messages.last
      message.author.should == @john
      message.body.should == 'message contents'
      
      message = @james.private_mailbox.messages.last
      message.author.should == @john
      message.body.should == 'message contents'
      
      message = @jane.private_mailbox.messages.last
      message.author.should == @john
      message.body.should == 'message contents'
    end
  end
  
end