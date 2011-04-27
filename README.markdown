# facteur #

Facteur allows you to add an email-like messaging system in your Rails 3 application. You can create many mailboxes for your users where they will be able to send and receive messages. Facteur supports ActiverRecord 3.0.x and Mongoid 2.0.x.

## Installation ##
  
In your Gemfile add the following line :

    gem 'facteur'
    
Then run the following command:

    bundle install
    
## Usage ##

First install the messaging system in your application :

    rails generate facteur:install  
    
This commands creates the migrations which creates the tables we need so don't forget to migrate your database :

    rake db:migrate

Then to activate __facteur__ in your user model, just include the addressee's model as follows :

    class User < ActiveRecord::Base  
      include Facteur::AddresseeModel
    end
    
or

    class User
      include Mongoid::Document
      include Facteur::AddresseeModel
    end
    
Starting from version 1.3, the name of the addressee model is no more restricted to 'User'. You can add a mailbox to any model.

## Messaging system ##

### Creating mailboxes ###

Each addressee must have a mailbox where he can receive messages. The mailboxes can be declared statically and/or dynamically. Let's start first by the static way :

    class Member < ActiveRecord::Base  
      include Facteur::AddresseeModel
      
      mailbox :private_mailbox, :default => true
      mailbox :public_mailbox
    end

The previous example declare two mailboxes that will be created for each member. The mailboxes are created when they are first accessed. Facteur generates for you two methods to access your mailboxes :

    # assuming that 'login' and 'password' are fields defined for the Member model
    @john = Member.create(:login => 'john', :password => 'pass')
    
    # Now, the mailboxes exist and they can be accessed
    @john.private_mailbox #=> generates and returns the private mailbox
    @john.public_mailbox #=> generates and returns the public mailbox
    
    # To check the mailboxes which where defined
    Member.mailboxes #=> [{:name=>:private_mailbox, :default=>true}, {:name=>:public_mailbox}]
    
It is also possible to create a mailbox dynamically. This mailbox will not be available for all the members but only for the one who created it :

    @john.create_mailbox(:new_mailbox) #=> true
    Member.mailboxes #=> [{:name=>:private_mailbox, :default=>true}, {:name=>:public_mailbox}]
    @john.mailboxes #=> [{:name=>:private_mailbox, :default=>true}, {:name=>:public_mailbox}, {:name=>:new_mailbox}]
    
After the previous example, the "news\_mailbox" is only avalaible to John. The names of the mailboxes must be unique. if you try to create a mailbox which already exists, the create_mailbox() method will fail and return false.

### Sending messages ###

It is possible to send a message to one or many addressee :

    @peter = Member.create(:login => 'peter', :password => 'pass')
    @mary = Member.create(:login => 'mary', :password => 'pass')
    
    @john.send_message('hello', :to => @peter, :in => :private_mailbox)
    @john.send_message('hello', :to => [@peter, @mary], :in => :public_mailbox)
    
The 'in' option is not mandatory. If it is not given, the message is delivered to the default mailbox. If there is no default mailbox defined then the method fails.

You can access the messages in a mailbox :

    @peter.private_mailbox.messages
    
To list the messages sent by a user :

    @john.sent_messages
    
### More methods ###

This section list the other methods available for each elements of the messaging system :

#### User ####

    mailboxes      : mailboxes assigned to this user
    sent_messages  : messages sent by the user

#### Mailbox ####

    addressee : who the mailbox is assigned to
    messages  : messages who are stored in the mailbox
    name      : the name of the mailbox

#### Message ####

    mailbox     : mailbox where the message is stored
    author      : user who send the message
    addressees  : who the message was sent to
    body        : body of the message
    subject     : subject of the message
    created_at  : date of creation
    
## Testing the gem ##

It is possible to test facteur by running the following command from the gem directory:

    rake spec:activerecord # activerecord tests
    rake spec:mongoid      # mongoid tests

## Note on Patches/Pull Requests ##
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright ##

Copyright (c) 2011 Rawane ZOSSOU. See LICENSE for details.
