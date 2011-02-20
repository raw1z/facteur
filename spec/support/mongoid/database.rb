module Database
  def self.connect
    Mongoid.configure do |config|
      name = "facteur_test"
      host = "localhost"
      config.master = Mongo::Connection.new.db(name)
      config.slaves = [
        Mongo::Connection.new(host, 27017, :slave_ok => true).db(name)
      ]
    end
  end
end