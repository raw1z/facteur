shared_examples_for "an addressee model" do
  context "when creating mailboxes" do
    it "creates a new mailbox" do
      mailbox = @john.create_mailbox(:news_mailbox)
      mailbox.should_not == false
      mailbox.addressee.should == @john
      @john.news_mailbox.should == mailbox
      
      lambda { mailbox = @peter.create_mailbox! :news_mailbox }.should_not raise_error
      mailbox.addressee.should == @peter
      @peter.news_mailbox.should == mailbox
    end
    
    it "could not create a mailbox with the name of an existing mailbox" do
      @john.private_mailbox.should_not be_nil
      @john.create_mailbox(:private_mailbox).should == false
      @peter.private_mailbox.should_not be_nil
      lambda { mailbox = @peter.create_mailbox! :private_mailbox }.should raise_error
    end
  end
  
  context "When adding a new mailbox" do
    before(:all) do
      User.class_exec do
        mailbox :added_mailbox
      end
    end
    
    it "should add the new mailbox to the class mailboxes" do
      User.mailboxes.should include({:name=>:added_mailbox})
    end
    
    it "should add the new mailbox to all the existing users" do
      User.all.each do |user|
        user.private_mailbox.should_not be_nil
        user.public_mailbox.should_not be_nil
        user.added_mailbox.should_not be_nil
      end
    end
  end
  
  context "when sending message" do    
    it "sends a message to another addressee" do
      message = @john.send_message('message contents', :to => @peter, :in => :private_mailbox)
      message.author.should == @john
      message.body.should == 'message contents'
      
      message = @john.send_message('message contents', :to => @peter, :in => :private_mailbox, :subject => 'test')
      message.author.should == @john
      message.body.should == 'message contents'
      message.subject.should == 'test'
    end
    
    it "sends the messages in the default mailbox" do
      message = @john.send_message('message contents', :to => @peter)
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
      message = @john.send_message('message contents', :to => [@peter, @james, @jane], :in => :private_mailbox)
      message.author.should == @john
      message.body.should == 'message contents'
      
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
    
    it "saves the messages sent" do
      @victoria.sent_messages.delete_all
      @victoria.send_message('message contents', :to => @john)
      @victoria.sent_messages.count.should == 1
      @victoria.sent_messages.first.body.should == 'message contents'
      @victoria.sent_messages.first.author.should == @victoria
      @victoria.sent_messages.first.addressees.should == [@john]
      @victoria.send_message('message contents', :to => @peter)
      @victoria.sent_messages.count.should == 2
      @victoria.sent_messages.last.body.should == 'message contents'
      @victoria.sent_messages.last.author.should == @victoria
      @victoria.sent_messages.last.addressees.should == [@peter]
      
      @victoria.sent_messages.delete_all
      @victoria.send_message('message contents', :to => [@peter, @james, @jane])
      @victoria.sent_messages.count.should == 1
      @victoria.sent_messages.first.body.should == 'message contents'
      @victoria.sent_messages.first.author.should == @victoria
      @victoria.sent_messages.first.addressees.should == [@peter, @james, @jane]
    end
  end
end