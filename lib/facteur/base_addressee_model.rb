module Facteur
  module BaseAddresseeModel
    extend ActiveSupport::Concern
        
    module ClassMethods
      # Define a mailbox. The following options are available:
      # <tt>:default</tt>:: defines the default mailbox. You must choose one default mailbox
      def mailbox(name, options={})
        mailbox = {:name => name}
        mailbox.merge! options
        mailboxes << mailbox
      end
      
      # Returns the mailboxes defined for the class
      def mailboxes
        @mailboxes ||= []
      end
      
      # check if a mailbox is defined
      def has_mailbox?(name)
        @mailboxes.each do |mailbox|
          return true if mailbox[:name] == name
        end
        false
      end
      
      # return the default mailbox name if set, else return nil
      def default_mailbox
        @mailboxes.select{ |mailbox| mailbox[:default] == true }.first[:name]
      end
    end
    
    module InstanceMethods
      #  returns the messages sent by this addressee
      def sent_messages
        sent_messages_mailbox.messages
      end
      
      # Sends a message to one or many addressees. The following options are available:
      #
      # <tt>:to</tt>:: the addressee or the list of addressees (mandatory)
      # <tt>:in</tt>:: the name of the mailbox in which the message is posted (mandatory)
      # <tt>:body</tt>:: the message's body (mandatory)
      #
      # Usage :
      #
      #     # send a message to one addressee
      #     @john.send_message('message contents', :to => @peter, :in => :private_mailbox)
      #
      #     # send a message to many addressees
      #     @john.send_message('message contents', :to => [@peter, @james], :in => :private_mailbox)
      def send_message(message, options)
        options[:body] = message
        if options[:to].respond_to?(:each)
          options[:to].each { |addressee| send_message_to(addressee, options[:in], options[:body], options[:subject]) }
        else
          send_message_to(options[:to], options[:in], options[:body], options[:subject])
        end
        
        store_in_sent_messages(message, options)
      end
      
      # Creates a new mailbox. if a mailbox with the same name already exists, it fails and returns false. If succeeded, it creates an accessor for the new mail box and returns true.
      # Example :
      #
      #     class User < ActiveRecord::base
      #        include Facteur::AddresseeModel
      #        
      #        mailbox :private_mailbox
      #     end
      #
      # The previous declaration will add : User#private_mailbox
      #     
      #     # supposing that a name field exists
      #     user = User.new(:name => 'John')
      #     user.create_mailbox :public_mailbox #=> return true
      #     user.create_mailbox :private_mailbox #=> return false
      def create_mailbox(name, options={})
        mailbox = mailboxes.build(:name => name.to_s, :default => options[:default])
        return false if mailbox.save == false
        mailbox
      end
      
      # Creates a new mailbox. if a mailbox with the same name already exists, it raises an exception. If succeeded, it creates an accessor for the new mail box and returns the created mailbox.
      def create_mailbox!(name, options={})
        if create_mailbox(name, options) == false
          raise "Mailboxes names must be unique. Can't create '#{name}'"
        end
        self.send "#{name}"
      end
      
      # generates the mailboxes accessors
      def method_missing(method, *args, &block)      
        begin
          super
        rescue NoMethodError, NameError
          mailbox = self.mailboxes.where(:name => method.to_s).first
          if mailbox.nil?
            super unless self.class.has_mailbox?(method)
            
            # if the unknown method matches one of the Model mailboxes, then the mailbox is created
            create_mailbox(method, self.class.mailboxes.select{ |m| m[:name] == method }.first)
          else
            return mailbox
          end
        end
      end
      
      # redefine the comparison method because for some weirds reasons, the original fails
      def ==(comparison_object)
        comparison_object.equal?(self) ||
          (self.class.to_s == comparison_object.class.to_s &&
            comparison_object.id == id && !comparison_object.new_record?)
      end
      
      private
      
      # return the sent messages mailbox
      def sent_messages_mailbox
        mailbox = self.mailboxes.where(:name => "sent_messages_mailbox").first
        mailbox || create_mailbox("sent_messages_mailbox")
      end
      
      # creates the mailboxes defined in the configuration
      def create_mailboxes
        self.class.mailboxes.each do |mailbox|
          options = {}.merge(mailbox)
          name = options.delete(:name)
          create_mailbox!(name, options)
        end
      end
      
      # send a message to an addressee
      def send_message_to(addressee, mailbox_name, contents, subject=nil)
        return false if addressee.nil? or contents.nil?
      
        mailbox_name = self.class.default_mailbox if mailbox_name.nil?
        return false if mailbox_name.nil?
      
        message = addressee.send(mailbox_name).messages.build(:subject => subject, :body => contents)
        message.author = self
        message.save ? message : false
      end
      
      # saves a message in the sent messages mailbox
      def store_in_sent_messages(message, options)
        # the addressees must be given
        return false if options[:to].blank?
        
        sent_message = sent_messages_mailbox.messages.build(:subject => options[:subject], :body => options[:body])
        sent_message.author = self
        
        if options[:to].respond_to?(:each)
          options[:to].each { |addressee| sent_message.addressees << addressee }
        else
          sent_message.addressees << options[:to]
        end
        
        sent_message.save ? sent_message : false
      end
    end
  end
end